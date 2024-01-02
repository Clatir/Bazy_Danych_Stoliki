document.addEventListener('DOMContentLoaded', function() {
    const availabilityForm = document.getElementById('availability-form');
    const reservationForm = document.getElementById('reservation-form');
    const reservationContainer = document.getElementById('reservation-container');

    // Obsługa formularza dostępności
    availabilityForm.onsubmit = function(event) {
        event.preventDefault();

        const date = document.getElementById('date').value;
        const startTime = document.getElementById('startTime').value;
        const duration = document.getElementById('duration').value;
        const minSeats = document.getElementById('minSeats').value;

        fetch('http://localhost:5000/check-availability', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ date, startTime, duration, minSeats }),
        })
            .then(response => response.json())
            .then(data => {
                if (data.available) {
                    alert("Stolik jest dostępny.");
                    reservationContainer.classList.remove('hidden'); // Pokaż formularz rezerwacji
                } else {
                    alert("Brak dostępnych stolików.");
                    reservationContainer.classList.add('hidden');
                }
            })
            .catch(error => {
                console.error('Wystąpił błąd:', error);
                alert("Wystąpił błąd podczas sprawdzania dostępności.");
            });
    };

    // Obsługa formularza rezerwacji
    reservationForm.onsubmit = function(event) {
        event.preventDefault();

        const imie = document.getElementById('imie').value;
        const nazwisko = document.getElementById('nazwisko').value;
        const email = document.getElementById('email').value;
        const telefon = document.getElementById('telefon').value;
        const uwagi = document.getElementById('uwagi').value;

        // Użyj tych samych danych, które zostały wysłane do sprawdzenia dostępności
        const date = document.getElementById('date').value;
        const startTime = document.getElementById('startTime').value;
        const duration = document.getElementById('duration').value;
        const minSeats = document.getElementById('minSeats').value;

        fetch('http://localhost:5000/make-reservation', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ date, startTime, duration, minSeats, imie, nazwisko, email, telefon, uwagi }),
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert("Rezerwacja została dokonana.");
                    reservationContainer.classList.add('hidden'); // Ukryj formularz rezerwacji
                    // Można tu dodać resetowanie formularzy, jeśli jest to potrzebne
                } else {
                    alert("Wystąpił problem przy dokonywaniu rezerwacji.");
                }
            })
            .catch(error => {
                console.error('Wystąpił błąd:', error);
                alert("Wystąpił błąd podczas dokonywania rezerwacji.");
            });
    };
});
