using bdBiblioteca.Data;
using bdBiblioteca.Models;
using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;

namespace bdBiblioteca.Controllers
{
    public class AutorController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
        private readonly Database db = new Database();

        public IActionResult CriarAutor()
        {
            return View();
        }

        [HttpPost]
        public IActionResult CriarAutor(Autor vm)
        {
            using var conn = db.GetConnection();
            using var cmd = new MySqlCommand("sp_autor_criar", conn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("p_nome", vm.nome);
            cmd.ExecuteNonQuery();

            return RedirectToAction("CriarAutor");
        }
    }
}
