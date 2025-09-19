using bdBiblioteca.Data;
using bdBiblioteca.Models;
using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;
using BCrypt.Net;

namespace bdBiblioteca.Controllers
{
    public class UsuariosController : Controller
    {
        private readonly Database db = new Database();
        public IActionResult Index()
        {
            return View();
        }

        public IActionResult CriarUsuario() { 
            return View(); 
        }

        [HttpPost]
        public IActionResult CriarUsuario(Usuarios vm)
        {
            using var conn = db.GetConnection();
            using var cmd = new MySqlCommand("sp_usuario_criar", conn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("p_nome", vm.nome);
            cmd.Parameters.AddWithValue("p_email", vm.email);
            cmd.Parameters.AddWithValue("p_senha_hash", vm.senha_hash);
            cmd.Parameters.AddWithValue("P_role", vm.role);
            cmd.ExecuteNonQuery();

            return RedirectToAction("CriarUsuario");
        }
    }
}
