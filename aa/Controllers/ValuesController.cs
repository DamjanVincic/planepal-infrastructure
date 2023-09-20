using aa.Models;
using HPlusSport.API.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Data;

namespace aa.Controllers
{
    [ApiVersion("1.0")]
    [Route("/products")]
    [Authorize]
    [ApiController]
    public class ProductsV1Controller : ControllerBase
    {
        private readonly ShopContext _shopContext;
        public ProductsV1Controller(ShopContext shopContext)
        {
            _shopContext = shopContext;
            _shopContext.Database.EnsureCreated();
        }
        [HttpGet]
        public async Task<IEnumerable<Product>> GetAllProducts([FromQuery]QuaryParametars quary)
        {

            IQueryable<Product> products = _shopContext.Products;
            if(!string.IsNullOrEmpty(quary.sreachterm))
            {
                products = products.Where(p => p.Sku.ToLower().Contains(quary.sreachterm.ToLower()) ||
                p.Name.ToLower().Contains(quary.sreachterm.ToLower()));
            }

            if(!string.IsNullOrEmpty(quary.Sku))
            {
                products=products.Where(p=> p.Sku ==quary.Sku);
            }
            if(!string.IsNullOrEmpty(quary.Name))
            {
                products = products.Where(p => p.Name.ToLower().Contains(quary.Name.ToLower()));
            }
            if(!string.IsNullOrEmpty(quary.SortBy))
            {
                if(typeof(Product).GetProperty(quary.SortBy) != null)
                {
                    products = products.OrderByCustom(quary.SortBy, quary.SortOrder);
                }
            }
            products = products.Skip(quary.Size * (quary.Page - 1)).Take(quary.Size);
            return await products.ToArrayAsync();
        }
        [HttpGet("byprice")]
        public async Task<IEnumerable<Product>> GetAllProductsByPrice([FromQuery] ProductQuaryParametars quary)
        {

            IQueryable<Product> products = _shopContext.Products;


            if (!string.IsNullOrEmpty(quary.Sku))
            {
                products = products.Where(p => p.Sku == quary.Sku);
            }
            if (!string.IsNullOrEmpty(quary.Name))
            {
                products = products.Where(p => p.Name.ToLower().Contains(quary.Name.ToLower()));
            }
            if (quary.minPrice != null)
            {
                products = products.Where(p => p.Price >= quary.minPrice);
            }
            if (quary.maxPrice != null)
            {
                products = products.Where(p => p.Price <= quary.maxPrice);
            }
                products = products.Skip(quary.Size * (quary.Page - 1)).Take(quary.Size);
            return await products.ToArrayAsync();
        }
        [HttpGet("{id}")]
        public async Task<ActionResult> GetProduct(int id)
        {
            var product = _shopContext.Products.FindAsync(id);
            if (product == null)
            {
                return NotFound();
            }
            return Ok(product);
        }
        [HttpPost]
        public async Task<ActionResult> PostProduct(Product product)
        {
            if (ModelState.IsValid)
            {
                return BadRequest();
            }
            _shopContext.Products.Add(product);
            await _shopContext.SaveChangesAsync();
            return CreatedAtAction("GetProduct", new { id = product.Id }, product);
        }
        [HttpPut("{id}")]
        public async Task<ActionResult> PutProduct(int id, [FromBody] Product product)
        {
            if (id != product.Id) { return BadRequest(); }
            _shopContext.Entry(product).State = EntityState.Modified;
            try
            {
                await _shopContext.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException ex)
            {
                if (!_shopContext.Products.Any(p => p.Id == id)) {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }
            return NoContent();
        }
        [HttpDelete("{id}")]
        public async Task<ActionResult<Product>> PutProduct(int id)
        {
            var product = await _shopContext.Products.FindAsync(id);
            if (product == null)
            {
                return NotFound();
            }
            _shopContext.Products.Remove(product);
            await _shopContext.SaveChangesAsync();
            return product;
        }
        [HttpPost]
        [Route("delete")]
        public async Task<ActionResult<Product>> DeleteMultiple([FromQuery] int[] ids)
        {
            var products = new List<Product>();
            foreach(var id in ids)
            {
                var product = await _shopContext.Products.FindAsync(id);
                if (product == null)
                {
                    return NotFound();
                }
                products.Add(product);
            }
            _shopContext.Products.RemoveRange(products);

           
           
            await _shopContext.SaveChangesAsync();
            return Ok(products);
        }
    }
    [ApiVersion("2.0")]
    [Route("/products")]
    [ApiController]
    public class ProductsV2Controller : ControllerBase
    {
        private readonly ShopContext _shopContext;
        public ProductsV2Controller(ShopContext shopContext)
        {
            _shopContext = shopContext;
            _shopContext.Database.EnsureCreated();
        }
        [HttpGet]
        public async Task<IEnumerable<Product>> GetAllProducts([FromQuery] QuaryParametars quary)
        {

            IQueryable<Product> products = _shopContext.Products.Where(p => p.IsAvailable == true); ;
            if (!string.IsNullOrEmpty(quary.sreachterm))
            {
                products = products.Where(p => p.Sku.ToLower().Contains(quary.sreachterm.ToLower()) ||
                p.Name.ToLower().Contains(quary.sreachterm.ToLower()));
            }

            if (!string.IsNullOrEmpty(quary.Sku))
            {
                products = products.Where(p => p.Sku == quary.Sku);
            }
            if (!string.IsNullOrEmpty(quary.Name))
            {
                products = products.Where(p => p.Name.ToLower().Contains(quary.Name.ToLower()));
            }
            if (!string.IsNullOrEmpty(quary.SortBy))
            {
                if (typeof(Product).GetProperty(quary.SortBy) != null)
                {
                    products = products.OrderByCustom(quary.SortBy, quary.SortOrder);
                }
            }
            products = products.Skip(quary.Size * (quary.Page - 1)).Take(quary.Size);
            return await products.ToArrayAsync();
        }
        [HttpGet("byprice")]
        public async Task<IEnumerable<Product>> GetAllProductsByPrice([FromQuery] ProductQuaryParametars quary)
        {

            IQueryable<Product> products = _shopContext.Products;


            if (!string.IsNullOrEmpty(quary.Sku))
            {
                products = products.Where(p => p.Sku == quary.Sku);
            }
            if (!string.IsNullOrEmpty(quary.Name))
            {
                products = products.Where(p => p.Name.ToLower().Contains(quary.Name.ToLower()));
            }
            if (quary.minPrice != null)
            {
                products = products.Where(p => p.Price >= quary.minPrice);
            }
            if (quary.maxPrice != null)
            {
                products = products.Where(p => p.Price <= quary.maxPrice);
            }
            products = products.Skip(quary.Size * (quary.Page - 1)).Take(quary.Size);
            return await products.ToArrayAsync();
        }
        [HttpGet("{id}")]
        public async Task<ActionResult> GetProduct(int id)
        {
            var product = _shopContext.Products.FindAsync(id);
            if (product == null)
            {
                return NotFound();
            }
            return Ok(product);
        }
        [HttpPost]
        public async Task<ActionResult> PostProduct(Product product)
        {
            if (ModelState.IsValid)
            {
                return BadRequest();
            }
            _shopContext.Products.Add(product);
            await _shopContext.SaveChangesAsync();
            return CreatedAtAction("GetProduct", new { id = product.Id }, product);
        }
        [HttpPut("{id}")]
        public async Task<ActionResult> PutProduct(int id, [FromBody] Product product)
        {
            if (id != product.Id) { return BadRequest(); }
            _shopContext.Entry(product).State = EntityState.Modified;
            try
            {
                await _shopContext.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException ex)
            {
                if (!_shopContext.Products.Any(p => p.Id == id))
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
        [HttpDelete("{id}")]
        public async Task<ActionResult<Product>> PutProduct(int id)
        {
            var product = await _shopContext.Products.FindAsync(id);
            if (product == null)
            {
                return NotFound();
            }
            _shopContext.Products.Remove(product);
            await _shopContext.SaveChangesAsync();
            return product;
        }
        [HttpPost]
        [Route("delete")]
        public async Task<ActionResult<Product>> DeleteMultiple([FromQuery] int[] ids)
        {
            var products = new List<Product>();
            foreach (var id in ids)
            {
                var product = await _shopContext.Products.FindAsync(id);
                if (product == null)
                {
                    return NotFound();
                }
                products.Add(product);
            }
            _shopContext.Products.RemoveRange(products);



            await _shopContext.SaveChangesAsync();
            return Ok(products);
        }
    }
}
