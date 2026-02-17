public class Fibonacci {
    // Método iterativo:
    public static int FiboIter(int n) {
        int actual = 0;
        int siguiente = 1;
        for(int i = 0; i < n; i++){
            int auxiliar = actual;
            actual = siguiente;
            siguiente = auxiliar + actual;
        }
        return actual;  
    }

    // Método recursivo: 
    // "i + 1" para que avance uno por uno
    public static int FibMem(int n, int i, int actual, int siguiente){
        if(i == n){
            return actual;
        } else {
            // Avanzamos i en 1 hasta llegar a n
            return FibMem(n, i + 1, siguiente, actual + siguiente);
        }
    }

    // Punto de entrada para la recursión
    public static int Fib2(int n){
        // Inicializamos i en 0, actual en 0 y siguiente en 1
        return FibMem(n, 0, 0, 1);
    }
    
    public static void main(String[] args) {
        int n = 6;
        System.out.println("FIBONACCI");  
        System.out.println();
        System.out.println("Iterativo: " + FiboIter(n));
        System.out.println("Recursivo: " + Fib2(n));     
    }
}
