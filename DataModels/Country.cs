
namespace GGlimpse.DataModels
{
    public class Country
    {
        public string country { get; set; } = null;
        public string description { get; set; } = null;
        public Tour[] tours { get; set; } = new Tour[0];

    }
}