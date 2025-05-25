import React, { useState } from "react";

export default function Comment() {
  const [comments, setComments] = useState([
    {
      id: 0,
      tiny_house_id: 3,
      full_name: "Kaan Civelek",
      rating: 1,
      comment: "Güzel bir konuttu.",
      review_date: "2025-05-06",
    },
    {
      id: 1,
      tiny_house_id: 3,
      full_name: "Ayşe Yılmaz",
      rating: 4,
      comment: "Sessiz ve temizdi.",
      review_date: "2025-05-05",
    },
  ]);

  return (
    <div style={{ padding: "20px" }}>
      <h5 style={{textAlign:"center"}}>Yorumlar</h5>
      {comments.map((c, index) => (
        <div
          key={index}
          className="comment-container"
          style={{
            display: "flex",
            justifyContent: "center",
            alignItems: "center",
            flexDirection: "column",
            width: "100%",
            maxWidth: "400px",
            padding: "20px",
            marginBottom: "20px",
            border: "1px solid #ccc",
            borderRadius: "10px",
            backgroundColor: "#fff",
            boxShadow: "0 2px 8px rgba(0, 0, 0, 0.1)",
          }}
        >
          <p>
            <strong>{c.full_name}</strong>
          </p>
          <p>
            ★<strong>Puan:</strong> {c.rating}
          </p>
          <p>
            <strong>{c.comment}</strong>
          </p>
          <p>
            <strong>{c.review_date}</strong>
          </p>
        </div>
      ))}
    </div>
  );
}
