using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Minik.Server.Models
{
    public class house_images
    {
        [Key]
        [Column("id")]
        public int Id { get; set; }

        [ForeignKey("TinyHouse")]
        [Column("tiny_house_id")]
        public int Tiny_house_id { get; set; }
        [Column("image_url")]
        public string image_url { get; set; }

    }
}
