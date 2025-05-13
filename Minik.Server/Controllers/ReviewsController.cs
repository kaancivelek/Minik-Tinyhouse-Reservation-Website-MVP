

using Microsoft.AspNetCore.Mvc;
using Minik.Server;
using Minik.Server.Models;
//using MyApi.Models;
//using MyApi.Repositories;

namespace MyApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ReviewsController : ControllerBase
    {
        private readonly ReviewRepository _repository;

        public ReviewsController(IConfiguration configuration)
        {
            var connStr = configuration.GetConnectionString("DefaultConnection");
            _repository = new ReviewRepository(connStr);
        }

        [HttpGet]
        public IEnumerable<Reviews> Get()
        {
            return _repository.GetAllReviews();
        }
    }
}
