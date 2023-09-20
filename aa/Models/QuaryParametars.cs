namespace aa.Models
{
    public class QuaryParametars
    {
        const int _maxSize = 100;
        private int _size = 50;
        public int Page { get; set; }
        public int Size
        {
            get { return _size; }
            set { _size = Math.Min(value, _maxSize); }
        }
        public string SortBy { get; set; } = "Id";
        private string _sortorder = "asc";
        public string Name { get; set; } = String.Empty;
        public string Sku { get; set; } = String.Empty;
        public string sreachterm { get; set; } = String.Empty;
        public string SortOrder
        {
            get { return _sortorder; }
            set
            {
                if (value == "asc" || value == "desc")
                {
                    _sortorder = value;
                }
            }
        }
    }
}
