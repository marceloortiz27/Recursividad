public class EjercicioDigitos {

    public static void main(String[] args) {
        int numero = 48944; 
        int buscado = 4;
        
        System.out.println("El número aparece: " + conteo(numero, buscado) + " veces.");
    }

    public static int conteo(int n, int digito) {
        // Caso base

        if(n < 0){
            n = -n;
        }

        if (n == 0) {
            if(digito == 0){
                return 1;
            }else{
                return 0;
            }
        }

        // Caso Recursivo
        int ultimo = n % 10;
        
        int restoDelConteo = conteo(n / 10, digito);
        
        if (ultimo == digito) {
            return 1 + restoDelConteo;
        } else {
            
            return 0 + restoDelConteo;
        }
    }
}