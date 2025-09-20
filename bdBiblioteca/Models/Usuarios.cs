namespace bdBiblioteca.Models
{
    public class Usuarios
    {
        public int id {  get; set; }
        public string nome { get; set; }
        public string email { get; set; }
        public String senha_hash { get; set; }
        public int ativo { get; set; }
        public string criado_em { get; set; }

        public string role { get; set; }

       
    }
}
