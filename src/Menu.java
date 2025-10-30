import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.util.Scanner;
import java.util.Date;

public class Menu {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        Connection conn = conexionBdd.getConnection();
        int opcion = 0;

        if (conn == null) {
            System.out.println("Error al abrir la bdd");
            return;
        }

        while (opcion != 4) {
            System.out.println("\nSeleccione una opción:");
            System.out.println("1. Insertar un usuario");
            System.out.println("2. Eliminar un reclamo");
            System.out.println("3. Listar los reclamos de un usuario");
            System.out.println("4. Salir");

            opcion = scanner.nextInt();
            scanner.nextLine(); 

            switch (opcion) {
                case 1:
                    String insert1 = "INSERT INTO Usuario (direccion, telefono) VALUES (?, ?)";
                    String insert2 = "INSERT INTO Empresa (nro_cuit, id_usuario, capacidad) VALUES (?, ?, ?)";
                    String insert3 = "INSERT INTO Persona (dni, id_usuario, telefono) VALUES (?, ?, ?)";

                    try {
                        PreparedStatement insert = conn.prepareStatement(insert1);
                        System.out.println("Ingrese la dirección y el teléfono del usuario:");
                        String direccion = scanner.nextLine();
                        String telefono = scanner.nextLine();
                        insert.setString(1, direccion);
                        insert.setString(2, telefono);
                        int cantinsertados = insert.executeUpdate();
                        if (cantinsertados > 0) {
                            System.out.println("Direccion y telefono insertado correctamente.");
                        }
                        
                        System.out.println("Va insertar una persona o una empresa?");
                        System.out.println("1. Persona");
                        System.out.println("2. Empresa");
                        int tipoEmPer = scanner.nextInt();
                        if (tipoEmPer == 1) {
                            PreparedStatement insertarPersona = conn.prepareStatement(insert3);
                            System.out.println("Ingrese el DNI y el telefono de la persona:");
                            int dni = scanner.nextInt();
                            String telPersona = scanner.nextLine();
                            
                            insertarPersona.setInt(1, dni);
                            insertarPersona.setString(3, telPersona);
                            cantinsertados = insertarPersona.executeUpdate();
                            if (cantinsertados > 0) {
                                System.out.println("Persona insertada correctamente.");
                            }
                        } else if (tipoEmPer == 2) {
                            PreparedStatement insertarEmpresa = conn.prepareStatement(insert2);
                            System.out.println("Ingrese el Nro CUIT y la capacidad de la empresa:");
                            int nroCuit = scanner.nextInt();
                            int capacidad = scanner.nextInt();
                            
                            insertarEmpresa.setInt(1, nroCuit);
                            insertarEmpresa.setInt(3, capacidad);
                            cantinsertados = insertarEmpresa.executeUpdate();
                            if (cantinsertados > 0) {
                                System.out.println("Empresa insertada correctamente.");
                            }
                        }
                    } catch (SQLException e) {
                        System.out.println("Error al insertar el usuario");
                        e.printStackTrace();
                    }
                    break;

                case 2:
                    System.out.println("Ingrese el número del reclamo que desea eliminar:");
                    int nroReclamo = scanner.nextInt();
                    String borrarReclamo = "DELETE FROM Reclamo WHERE nro_reclamo = ?";
                    try {
                        PreparedStatement borrar = conn.prepareStatement(borrarReclamo);
                        borrar.setInt(1, nroReclamo);
                        int cant = borrar.executeUpdate();
                        if (cant > 0) {
                            System.out.println("Reclamo eliminado correctamente.");
                        } else {
                            System.out.println("No se encontro el reclamo con ese número.");
                        }
                    } catch (SQLException e) {
                        System.out.println("Error al eliminar el reclamo");
                        e.printStackTrace();
                    }
                    break;

                case 3:
                    System.out.println("Ingrese el id del usuario para mostrar sus reclamos:");
                    int id_usuario = scanner.nextInt();
                    String query1 = "SELECT * FROM Reclamo WHERE id_usuario = ?";
                    try {
                        PreparedStatement consulta = conn.prepareStatement(query1);
                        consulta.setInt(1, id_usuario);
                        ResultSet resultSet = consulta.executeQuery();
                        System.out.println("Reclamos del usuario " + id_usuario + ":");
                        while (resultSet.next()) {
                            int id_usuario_reclamo = resultSet.getInt("id_usuario");
                            int nro = resultSet.getInt("nro_reclamo");
                            int codigo_motivo = resultSet.getInt("codigoMot");
                            Date fecha = resultSet.getDate("fecha_reclamo");
                            Time hora = resultSet.getTime("hora_reclamo");
                            Date fecha_sol = resultSet.getDate("fecha_solucion");
                            System.out.println("Id_usuario: " + id_usuario_reclamo + ", Nro Reclamo: " + nro +
                                    ", Codigo Motivo: " + codigo_motivo + ", Fecha Reclamo: " + fecha +
                                    ", Hora Reclamo: " + hora + ", Fecha Solucion: " + fecha_sol);
                        }
                    } catch (SQLException e) {
                        System.out.println("Error al listar los reclamos");
                        e.printStackTrace();
                    }
                    break;

                case 4:
                    System.out.println("Saliendo...");
                    break;

                default:
                    System.out.println("Opcion incorrecta.");
                    break;
            }
        }

        try {
            conn.close();
            System.out.println("Byee base de datos cerrada");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

