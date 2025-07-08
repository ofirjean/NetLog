from flask import Flask, request, jsonify
import psycopg2
from config import DB_HOST, DB_PORT, DB_NAME, DB_USER, DB_PASS

app = Flask(__name__)

def get_db_connection():
    return psycopg2.connect(
        host=DB_HOST,
        port=DB_PORT,
        dbname=DB_NAME,
        user=DB_USER,
        password=DB_PASS
    )

@app.route('/data', methods=['POST'])
def insert_data():
    try:
        data = request.get_json()
        name = data.get('name')
        value = data.get('value')
        time = data.get('time')

        if not name or value is None or not time:
            return jsonify({"error": "Missing required fields"}), 400

        conn = get_db_connection()
        cur = conn.cursor()

        cur.execute(
            "INSERT INTO entries (name, value, time) VALUES (%s, %s, %s)",
            (name, value, time)
        )
        conn.commit()
        cur.close()
        conn.close()

        return jsonify({"message": "Data inserted successfully"}), 201

    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/data', methods=['GET'])
def get_data():
    try:
        conn = get_db_connection()
        cur = conn.cursor()

        cur.execute("SELECT id, name, value, time FROM entries")
        rows = cur.fetchall()

        cur.close()
        conn.close()

        result = []
        for row in rows:
            result.append({
                "id": row[0],
                "name": row[1],
                "value": row[2],
                "time": row[3]
            })

        return jsonify(result), 200

    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
