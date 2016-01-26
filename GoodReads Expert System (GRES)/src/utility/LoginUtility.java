package utility;

import java.io.IOException;
import java.io.Serializable;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
/**
 * Classe di utility per la gestione della lista utenti, 
 * criptaggio delle password e login
 * @author Mattia Menna
 *
 */


public class LoginUtility implements Serializable{
	/**
	 * Map contenente  username, password e indirizzi email degli utenti registrati
	 */
	static HashMap<String, String> i=getCurrentUserList(); 
	
	/**
	 * Aggiunge un utente indicandone username e password, quindi salva la Map nel file
	 * @param username
	 * @param password
	 */
	public boolean insertUser(String username, String password) { 
		if(!containsUser(username)) {
			i.put(username, cryptPassword(password));
			if(salva())
				return true;
			else 
				return false;
		}
		else return false;
	}
	
	/**
	 * Verifica se l'username in input è già contenuto nella Map
	 * @param username Username da verificare
	 * @return Booleano esito della verifica
	 */
	public boolean containsUser(String username) { 
		return i.containsKey(username);
	}
	
	/**
	 * Metodo per la rimozione di un utente dalla lista utenti
	 * @param username Utente da rimuovere
	 * @return Esito della rimozione	
	 */
	public boolean deleteUser(String username) {
		try {
			
			if(i.remove(username).equals(""))
				return false;
			else {
				salva();
				return true;
			}
		}
		
		catch (NullPointerException e) {
			return false;
		}
	}
	
	/**
	 * Verifica se l'username in input è già contenuto nella Map
	 * @param username Username da verificare
	 * @return Booleano esito della verifica
	 */
	private String getPassword(String username) { 
		return i.get(username); 
	}
	/**
	 * Verifica la correttezza della password in input per l'username in input
	 * @param username 
	 * @param password
	 * @return Booleano risultato della verifica
	 */
	public boolean correctPassword(String username, String password) { 
		if(this.containsUser(username))   
			return (cryptPassword(password).equals(this.getPassword(username)));
		else return false;
	}
	/**
	 * Funzione di criptaggio delle password
	 * @param password
	 * @return Stringa rappresentante la password criptata
	 */
	private String cryptPassword(String password)
	   {
	   try {
	   	String passwordCrypted="";
	   	MessageDigest digest = MessageDigest.getInstance("MD5");
	   	byte[] b=digest.digest(password.getBytes());
	   	for(int i=0;i<b.length;i++) {
	   	Byte bi=b[i];
	   	passwordCrypted +=bi.toString();
	   	
	   	}
	   	return passwordCrypted;
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "password";
		}
	   }
	/**
	 * Metodo per il caricamento della lista degli utenti dal file
	 * @return HashMap contenente la lista degli utenti con relative password
	 */
	private static HashMap<String, String> getCurrentUserList() {
		try {
			return LoginFileUtility.carica();
		}
		catch(ClassNotFoundException | IOException e) { 
			return new HashMap<String, String>();
		}
	}
	/**
	 * Metodo per il salvataggio su file della lista utenti con relative password
	 * @return  Esito del salvataggio
	 */
	private boolean salva() {
		try {
			LoginFileUtility.salva(i);
			return true;
		} 
		catch (IOException e) {
		return false;
		}
	}

}