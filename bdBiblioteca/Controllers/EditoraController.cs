using bdBiblioteca.Data;
using bdBiblioteca.Models;
using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;

namespace bdBiblioteca.Controllers
{
    public class EditoraController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
        private readonly Database db = new Database();

        public IActionResult CriarEditora()
        {
            return View();
        }

        [HttpPost]
        public IActionResult CriarEditora(Editora vm)
        {
            using var conn = db.GetConnection();
            using var cmd = new MySqlCommand("sp_editora_criar", conn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("p_nome", vm.nome);
            cmd.ExecuteNonQuery();

            return RedirectToAction("CriarEditora");
        }
    }
}
