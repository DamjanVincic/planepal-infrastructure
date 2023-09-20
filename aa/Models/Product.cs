using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;
namespace aa.Models
{
    public class Product
    {
        public int Id { get; set; }
        [Required]
        public string Name { get; set; }
        [Required]
        public string Sku { get; set; }
        public decimal Price { get; set; }
        public Boolean IsAvailable { get; set; }
        [Required]
        public int CategoryId { get; set; }

        [JsonIgnore]
        public virtual Category? Category { get; set; }
    }
}
