from flask import Flask, request, jsonify, render_template
import mysql.connector
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

def create_db_connection():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        passwd="",
        database="testdb"
    )

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/check-availability', methods=['POST'])
def check_availability():
    data = request.json
    query = "SELECT * FROM testdb.Stoliki WHERE Liczba_Miejsc >= '{}' AND ID_Stolika NOT IN (SELECT ID_Stolika FROM testdb.Rezerwacje WHERE Data = '{}' AND ('{}' < `Czas koniec` AND ADDTIME('{}', '{}') > `Czas poczatek`))".format(data['minSeats'], data['date'], data['startTime'], data['startTime'], data['duration'])
    conn = create_db_connection()
    cursor = conn.cursor()
    try:
        cursor.execute(query)
        available_tables = cursor.fetchall()
        cursor.close()
        return jsonify({"available": len(available_tables) > 0})
    except mysql.connector.Error as e:
        return jsonify({"error": str(e), "query": query})

@app.route('/make-reservation', methods=['POST'])
def make_reservation():
    data = request.json
    query_add_client = "INSERT INTO testdb.Klienci (Imie, Nazwisko, Email, Telefon) VALUES ('{}', '{}', '{}', '{}')".format(data['imie'], data['nazwisko'], data['email'], data['telefon'])
    conn = create_db_connection()
    cursor = conn.cursor()
    try:
        cursor.execute(query_add_client)
        client_id = cursor.lastrowid

        query_add_reservation = "INSERT INTO testdb.Rezerwacje (ID_Klienta, ID_Stolika, Data, `Czas poczatek`, `Czas koniec`, Uwagi) VALUES ('{}', (SELECT ID_Stolika FROM testdb.Stoliki WHERE Liczba_Miejsc >= '{}' LIMIT 1), '{}', '{}', ADDTIME('{}', '{}'), '{}')".format(client_id, data['minSeats'], data['date'], data['startTime'], data['startTime'], data['duration'], data.get('uwagi', ''))
        cursor.execute(query_add_reservation)
        conn.commit()
        cursor.close()
        return jsonify({"success": True, "message": "Rezerwacja została dokonana."})
    except mysql.connector.Error as e:
        return jsonify({"error": str(e), "query": query_add_client})

@app.route('/raw-query', methods=['POST'])
def raw_query():
    data = request.json
    query = data['query']
    conn = create_db_connection()
    cursor = conn.cursor()
    try:
        cursor.execute(query)
        result = cursor.fetchall()
        cursor.close()
        return jsonify({"result": result})
    except mysql.connector.Error as e:
        return jsonify({"error": str(e), "query": query})


@app.route('/check-availability-floor', methods=['POST'])
def check_availability_floor():
    data = request.json
    date = data['date']
    floor = data['floor']

    # Bezpośrednie wstawianie danych do zapytania SQL
    query = f"SELECT * FROM testdb.Stoliki WHERE Pietro = '{floor}' AND ID_Stolika NOT IN (SELECT ID_Stolika FROM testdb.Rezerwacje WHERE Data = '{date}')"
    conn = create_db_connection()
    cursor = conn.cursor()
    try:
        cursor.execute(query)
        available_tables = cursor.fetchall()

        cursor.close()
        table_numbers = [table[0] for table in available_tables]
        if  available_tables==[]:
            return jsonify({"message": "Brak wolnych stolików"})

        return jsonify({"availableTables": table_numbers})
    except mysql.connector.Error as e:
        return jsonify({"error": str(e), "query": query})

if __name__ == '__main__':
    app.run(debug=True, port=5000)
