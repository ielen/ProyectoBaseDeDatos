import java.sql.Connection;

public class pruebaConexionBdd {
    public static void main(String[] args) {
        Connection conn = conexionBdd.getConnection(); 

        if (conn != null) {
            System.out.println("Conexion exitosa");
        } else {
            System.out.println("No se pudo conectar.");
        }

        conexionBdd.Desconectar(conn);
    }
}

