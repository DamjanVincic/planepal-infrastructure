namespace aa.Models
{
    public class ProductQuaryParametars
    {

        const int _maxSize = 100;
        private int _size = 50;
        public int Page { get; set; }
        public decimal? minPrice { get; set; }
        public decimal? maxPrice { get; set; }
        public int Size
        {
            get { return _size; }
            set { _size = Math.Min(value, _maxSize); }
        }
        public string Name { get; set; } = String.Empty;
        public string Sku { get; set; } = String.Empty;
       
    }
}
