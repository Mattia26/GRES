

public class DefaultChoises {
	
	
	private static String lungo = "";
	
	private static String esplicito = "";
	
	private static String violento = "";
	
	private static String imprevedibile = "";
	
	private static String leggero = "";
	
	private static String divertente = "";
	
	private static String serie = "";
	
	

	
	public static void setLungo(String x){
		lungo = x;
	}
	
	public static String getLungo(){
		return lungo;
	}
	
	public static void setEsplicito(String x){
		esplicito = x;
	}
	
	public static String getEsplicito(){
		return esplicito;
	}
	
	public static void setViolento(String x){
		violento = x;
	}
	
	public static String getViolento(){
		return violento;
	}
	
	public static void setImprevedibile(String x){
		imprevedibile = x;
	}
	
	public static String getImprevedibile(){
		return imprevedibile;
	}
	
	public static void setLeggero(String x){
		leggero = x;
	}
	
	public static String getLeggero(){
		return leggero;
	}
	
	public static void setDivertente(String x){
		divertente = x;
	}
	
	public static String getDivertente(){
		return divertente;
	}
	
	public static void setSerie(String x){
		serie = x;
	}
	
	public static String getSerie(){
		return serie;
	}
	
	

	
	
	
	
	public static String print(){
		return lungo + "\n" + esplicito + "\n" + violento + "\n" + imprevedibile + "\n" + leggero
				+ "\n" + divertente + "\n" + serie;
	}
	
	
	

}
