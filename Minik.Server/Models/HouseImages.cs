using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Minik.Server.Models
{
    [Table("house_images")]
    public class HouseImages
    {
        [Key]
        [Column("id")]
        public int Id { get; set; }

        [ForeignKey("TinyHouse")]
        [Column("tiny_house_id")]
        public int Tiny_house_id { get; set; }
        [Column("image_url")]
        public string Image_url { get; set; }

    }
}
