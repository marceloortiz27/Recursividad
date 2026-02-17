public class Main {
    public static void main(String[] args) {

        if (Laberinto.buscar(1, 1)) {
            System.out.println("¡Salida encontrada!");
        } else {
            System.out.println("No hay solución.");
        }
        Laberinto.mostrarLab();
    }
}
