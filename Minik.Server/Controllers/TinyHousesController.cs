using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Minik.Server.Data;
using Minik.Server.Models;

namespace Minik.Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TinyHousesController : ControllerBase
    {
        private readonly AppDbContext _context;

        public TinyHousesController(AppDbContext context)
        {
            _context = context;
        }

        // GET: api/TinyHouses
        [HttpGet]
        public async Task<ActionResult<IEnumerable<TinyHouse>>> GetTinyHouses()
        {
            return await _context.TinyHouses.ToListAsync();
        }

        // GET: api/TinyHouses/5
        [HttpGet("{id}")]
        public async Task<ActionResult<TinyHouse>> GetTinyHouse(int id)
        {
            var tinyHouse = await _context.TinyHouses.FindAsync(id);

            if (tinyHouse == null)
            {
                return NotFound();
            }

            return tinyHouse;
        }

        // POST: api/TinyHouses
        [HttpPost]
        public async Task<ActionResult<TinyHouse>> PostTinyHouse(TinyHouse tinyHouse)
        {
            _context.TinyHouses.Add(tinyHouse);
            await _context.SaveChangesAsync();

            return CreatedAtAction(nameof(GetTinyHouse), new { id = tinyHouse.Id }, tinyHouse);
        }

        // PUT: api/TinyHouses/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutTinyHouse(int id, TinyHouse tinyHouse)
        {
            if (id != tinyHouse.Id)
            {
                return BadRequest();
            }

            _context.Entry(tinyHouse).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!TinyHouseExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // DELETE: api/TinyHouses/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteTinyHouse(int id)
        {
            var tinyHouse = await _context.TinyHouses.FindAsync(id);
            if (tinyHouse == null)
            {
                return NotFound();
            }

            _context.TinyHouses.Remove(tinyHouse);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool TinyHouseExists(int id)
        {
            return _context.TinyHouses.Any(e => e.Id == id);
        }
    }
}
