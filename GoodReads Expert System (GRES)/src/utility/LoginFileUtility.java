package utility;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.IOException;
import java.util.HashMap;
/**Classe di utility per gestire il file dei dati di accesso
 * 
 * @author Mattia Menna
 */
public class LoginFileUtility{
	/**
	 * Attributo statico e non modificabile che indica il nome del file
	 * in cui sarà salvata la Map contenente username e password di operatori e
	 * amministratore
	 */
	static final String NAMEFILE="LoginData"; 
	
	/**
	 * Salva l'HashMap nel file "NAMEFILE"
	 * @param f HashMap da salvare
	 * @throws FileNotFoundException
	 * @throws IOException
	 */
	static void salva(HashMap<String,String> f) throws FileNotFoundException, IOException{
			FileOutputStream fileToSave = new FileOutputStream(NAMEFILE);
			ObjectOutputStream fileSaved = new ObjectOutputStream (fileToSave);
			fileSaved.writeObject(f);
			fileSaved.close();
		}
	/**
	 * Carica il file "NAMEFILE" in un HashMap
	 * @return L'HashMap contenente i dati nel file
	 * @throws IOException
	 * @throws ClassNotFoundException
	 */
	static HashMap<String,String> carica()
			throws IOException,ClassNotFoundException{ 
		FileInputStream inputFile = new FileInputStream(NAMEFILE);
		ObjectInputStream fileToLoad = new ObjectInputStream(inputFile);
		HashMap<String,String> fileLoaded = (HashMap<String,String>) fileToLoad.readObject();
		fileToLoad.close();
		return fileLoaded;
	}
	
	
	
}
