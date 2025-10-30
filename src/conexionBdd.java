import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class conexionBdd {

    private static String driver = "com.mysql.cj.jdbc.Driver";
    private static String url = "jdbc:mysql://localhost:3306/servicio"; //dirección de la base de datos
    private static String username = "root"; // el usuario por defecto
    private static String password = "jennifer13"; // la contrase;a de mysql

    public static Connection getConnection() {
        try {
            Class.forName(driver);
            return DriverManager.getConnection(url, username, password);
        } catch (ClassNotFoundException e) {
            System.out.println("Error no se encontro");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("Error");
            e.printStackTrace();
        }
        return null;
    }

    public static void Desconectar (Connection conn){
        try {
            conn.close();
            System.out.println("Cierro bdd");
        } catch (SQLException e) {
            System.out.println("Error al cerrar la bdd");
            e.printStackTrace();
        }
    }
}

