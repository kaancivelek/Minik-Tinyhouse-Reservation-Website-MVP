using Minik.Server.Models;

namespace Minik.Server
{
    public class ReviewRepository
    {
        private string? connStr;

        public ReviewRepository(string? connStr)
        {
            this.connStr = connStr;
        }

        internal IEnumerable<Reviews> GetAllReviews()
        {
            throw new NotImplementedException();
        }
    }
}
