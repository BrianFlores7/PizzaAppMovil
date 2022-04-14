using Microsoft.EntityFrameworkCore;

namespace PizzaStore.Models
{
    public class Pizza
    {
        public int Id { get; set; }
        public string? Name { get; set; }
        public string? Description { get; set; }
    }

    public class Order
    {
        public int Id { get; set; }
        public string? PizzaName { get; set; }
        public string? PizzaDescription { get; set; }
        public string? Direction { get; set; }
    }

    class PizzaDb : DbContext
    {
        public PizzaDb(DbContextOptions options) : base(options) { }
        public DbSet<Pizza> Pizzas { get; set; }

        public DbSet<Order> Orders { get; set; }
    }

}

