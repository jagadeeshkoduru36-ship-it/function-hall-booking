import React, { useEffect, useState } from "react";
import { createRoot } from "react-dom/client";
import "./style.css";

const API_URL = import.meta.env.VITE_API_URL || "http://localhost:8080";

function App() {
  const [halls, setHalls] = useState([]);
  const [message, setMessage] = useState("Loading halls...");

  useEffect(() => {
    fetch(`${API_URL}/api/halls`)
      .then((response) => {
        if (!response.ok) throw new Error("Backend unavailable");
        return response.json();
      })
      .then((data) => {
        setHalls(data);
        setMessage("");
      })
      .catch(() => {
        setMessage("Connect the Java backend and PostgreSQL to load halls.");
      });
  }, []);

  return (
    <div className="app">
      <header>
        <h1>Function Hall Booking</h1>
        <p>Book your function hall and services online.</p>
      </header>

      <main>
        <h2>Available Function Halls</h2>

        {message && <p className="message">{message}</p>}

        <div className="hall-grid">
          {halls.map((hall) => (
            <article className="hall-card" key={hall.hallId}>
              <h3>{hall.hallName}</h3>
              <p>📍 {hall.location}</p>
              <p>👥 Capacity: {hall.capacity}</p>
              <p>💰 ₹{hall.hallPrice} / day</p>
              <p>{hall.description}</p>
              <button>Book Now</button>
            </article>
          ))}
        </div>
      </main>
    </div>
  );
}

createRoot(document.getElementById("root")).render(<App />);
