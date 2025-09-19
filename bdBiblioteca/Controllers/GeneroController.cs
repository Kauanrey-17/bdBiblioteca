using bdBiblioteca.Data;
using bdBiblioteca.Models;
using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;

namespace bdBiblioteca.Controllers
{
    public class GeneroController : Controller
    {
        private readonly Database db = new Database();
        public IActionResult Index()
        {
            return View();
        }
        public IActionResult CriarGenero()
        {
            return View();
        }

        [HttpPost]
        public IActionResult CriarGenero(Genero vm)
        {
            using var conn = db.GetConnection();
            using var cmd = new MySqlCommand("sp_genero_criar", conn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("p_nome", vm.nome);
            cmd.ExecuteNonQuery();

            return RedirectToAction("CriarGenero");
        }
    }
}
