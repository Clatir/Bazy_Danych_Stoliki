from datetime import timedelta, datetime

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
    min_seats = data['minSeats']
    date = data['date']
    start_time = data['startTime']
    duration = data['duration']
    end_time = (datetime.strptime(start_time, '%H:%M') + timedelta(hours=int(duration))).strftime('%H:%M')

    query = "SELECT * FROM testdb.Stoliki WHERE Liczba_Miejsc >= %s AND ID_Stolika NOT IN (SELECT ID_Stolika FROM testdb.Rezerwacje WHERE Data = %s AND (%s < `Czas koniec` AND ADDTIME(%s, %s) > `Czas poczatek`))"
    conn = create_db_connection()
    cursor = conn.cursor()
    try:
        cursor.execute(query, (min_seats, date, start_time, start_time, duration))
        available_tables = cursor.fetchall()
        cursor.close()
        return jsonify({"available": len(available_tables) > 0})
    except mysql.connector.Error as e:
        return jsonify({"error": str(e), "query": query})

@app.route('/make-reservation', methods=['POST'])
def make_reservation():
    data = request.json
    imie = data['imie']
    nazwisko = data['nazwisko']
    email = data['email']
    telefon = data['telefon']
    min_seats = data['minSeats']
    date = data['date']
    start_time = data['startTime']
    duration = data['duration']
    end_time = (datetime.strptime(start_time, '%H:%M') + timedelta(hours=int(duration))).strftime('%H:%M')

    conn = create_db_connection()
    cursor = conn.cursor()
    try:
        query_add_client = "INSERT INTO testdb.Klienci (Imie, Nazwisko, Email, Telefon) VALUES (%s, %s, %s, %s)"
        cursor.execute(query_add_client, (imie, nazwisko, email, telefon))
        client_id = cursor.lastrowid

        query_add_reservation = "INSERT INTO testdb.Rezerwacje (ID_Klienta, ID_Stolika, Data, `Czas poczatek`, `Czas koniec`, Uwagi) VALUES (%s, (SELECT ID_Stolika FROM testdb.Stoliki WHERE Liczba_Miejsc >= %s LIMIT 1), %s, %s, ADDTIME(%s, %s), %s)"
        uwagi = data.get('uwagi', '')
        cursor.execute(query_add_reservation, (client_id, min_seats, date, start_time, start_time, duration, uwagi))
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

    query = "SELECT * FROM testdb.Stoliki WHERE Pietro = %s AND ID_Stolika NOT IN (SELECT ID_Stolika FROM testdb.Rezerwacje WHERE Data = %s)"
    conn = create_db_connection()
    cursor = conn.cursor()
    try:
        cursor.execute(query, (floor, date))
        available_tables = cursor.fetchall()
        table_numbers = [table[0] for table in available_tables]
        if len(table_numbers) ==0:
            return("No available tables")
        cursor.close()
        return jsonify({"availableTables": table_numbers})
    except mysql.connector.Error as e:
        return jsonify({"error": str(e), "query": query})

if __name__ == '__main__':
    app.run(debug=True, port=5000)
