
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using Minik.Server.Models;

namespace Minik.Server.Repositories
{
    public class ReviewRepository
    {
        private readonly string _connectionString;

        public ReviewRepository(string connectionString)
        {
            _connectionString = connectionString;
        }

        public List<Reviews> GetAllReviews()
        {
            List<Reviews> reviews = new List<Reviews>();

            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                string query = "SELECT id, rating, comment, review_date FROM reviews";
                SqlCommand command = new SqlCommand(query, connection);

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {
                    Reviews review = new Reviews
                    {
                        Id = reader.GetInt32(0),
                        Rating = reader.GetInt32(1),
                        Comment = reader.GetString(2),
                        ReviewDate = reader.GetDateTime(3)
                    };
                    reviews.Add(review);
                }

                reader.Close();
            }

            return reviews;
        }
    }
}
