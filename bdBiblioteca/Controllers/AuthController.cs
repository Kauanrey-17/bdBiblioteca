using Microsoft.AspNetCore.Mvc;
using bdBiblioteca.Data;
using MySql.Data.MySqlClient;
using Microsoft.AspNetCore.Identity;


namespace bdBiblioteca.Controllers
{
    public class AuthController : Controller
    {
        private readonly Database db = new Database();

        [HttpGet]
        public IActionResult Login(string returnUrl = null)
        {
            ViewBag.ReturnUrl = returnUrl;
            return View();
        }

        [HttpPost, ValidateAntiForgeryToken]
        public IActionResult Login(String email, String senha, string? returnUrl = null)
        {
            if (string.IsNullOrWhiteSpace(email) || string.IsNullOrWhiteSpace(senha))
            {
                ViewBag.Error = "Informe e-mail e senha.";
                return View();
            }
            using var conn = db.GetConnection();
            using var cmd = new MySqlCommand("sp_usuario_obter_por_email", conn) { CommandType = System.Data.CommandType.StoredProcedure };
            cmd.Parameters.AddWithValue("p_email", email);
            using var rd = cmd.ExecuteReader();
            if (!rd.Read()) {
                ViewBag.Error = "Usuario nao encontrado";
                return View();
            }
            var id = rd.GetInt32("id");
            var nome = rd.GetString("nome");
            var role = rd.GetString("role");
            var ativo = rd.GetBoolean("ativo");
            var senhaHash = rd["senha_hash"] as string ?? "";

        }
        public IActionResult Index()
        {
            return View();
        }
    }
}
