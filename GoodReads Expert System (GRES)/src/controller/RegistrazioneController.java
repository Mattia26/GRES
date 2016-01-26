package controller;

import java.net.URL;
import java.time.LocalDate;
import java.util.ResourceBundle;


import Main.Main;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.control.ComboBox;
import javafx.scene.control.DatePicker;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;
import javafx.stage.Stage;
import net.sf.clipsrules.jni.Environment;
import utility.LoginUtility;
/**
 * Classe di controllo per l'interfaccia di registrazione
 * @author Mattia Menna
 *
 */
public class RegistrazioneController implements Initializable {
	/**
	 * Texfield dell'username
	 */
	@FXML
	private TextField username;
	/**
	 * TextField della password
	 */
	@FXML
	private PasswordField password;
	/**
	 * Campo per l'immissione della data di nascita
	 */
	@FXML
	private DatePicker data;
	/**
	 * ComboBox per la scelta dell'autore preferito
	 */
	@FXML
	private ComboBox<String> autore;
	/**
	 * ComboBox per la scelta del genere preferito
	 */
	@FXML
	private ComboBox<String> genere;
	
	/**
	 * Funzione che inizializza le ComboBox con adeguati parametri
	 */
	public void initialize(URL arg0, ResourceBundle arg1){
		
		autore.getItems().addAll("J.K. Rowling", "J.R.R. Tolkien", "Charles Dickens", "Sir Arthur Conan Doyle"
				,"Isaac Asimov","George Orwell","Ken Follett","Stephen King","Nessuno di questi");
		autore.setValue("Nessuno di questi");
		genere.getItems().addAll("Avventura","Storico","Sociale","Psicologico","Fantastico","Giallo",
				"Gotico","Rosa","Fantascienza","Nessuno");
		genere.setValue("Nessuno");
	}	
	/**
	 * Funzione che gestisce le operazioni da effettuare alla pressione del tasto conferma
	 */
	@FXML
	public void conferma(){
		
		Main.clips.assertString("(login)");
		Main.clips.assertString("(autore si)");
		
		if(!username.getText().equals("") && !password.getText().equals("") && data.getValue() != null){
			LoginUtility lu = new LoginUtility();
			
			lu.insertUser(username.getText(), password.getText());
			
			Environment clips = new Environment();
			
			clips.assertString("(età)");
			
			LocalDate today = LocalDate.now();
			int eta = today.getYear() - data.getValue().getYear();
			
			if(eta < 16){
				clips.assertString("(esplicito no)");
				if(eta < 14)
					clips.assertString("(violento no)");
			}
			
			if(autore.getValue().equals("J.K. Rowling")){
				clips.assertString("(imprevedibile si)");
				clips.assertString("(violento no)");
				clips.assertString("(leggero si)");
				clips.assertString("(serie si)");
				
			}
			
			if(autore.getValue().equals("J.R.R. Tolkien")){
				clips.assertString("(lungo si)");
				clips.assertString("(divertente no)");
				clips.assertString("(esplicito no)");
				clips.assertString("(leggero si)");
			}
			
			if(autore.getValue().equals("Charles Dickens")){
				clips.assertString("(lungo si)");
				clips.assertString("(divertente no)");
				clips.assertString("(esplicito si)");
				clips.assertString("(leggero si)");
			}
			
			if(autore.getValue().equals("Sir Arthur Conan Doyle")){
				clips.assertString("(divertente si)");
				clips.assertString("(lungo no)");
				clips.assertString("(imprevedibile si)");
				clips.assertString("(leggero si)");
				
			}
			
			if(autore.getValue().equals("Isaac Asimov")){
				clips.assertString("(lungo no)");
				clips.assertString("(serie si)");
				clips.assertString("(imprevedibile si)");
				clips.assertString("(leggero si)");
			}
			
			if(autore.getValue().equals("George Orwell")){
				clips.assertString("(lungo no)");
				clips.assertString("(divertente no)");
				clips.assertString("(leggero no)");
				clips.assertString("(serie no)");
			}
			
			if(autore.getValue().equals("Ken Follett")){
				clips.assertString("(lungo si)");
				clips.assertString("(esplicito si)");
				clips.assertString("(violento si)");
				clips.assertString("(serie si)");
			}
			
			if(autore.getValue().equals("Stephen King")){
				clips.assertString("(violento si)");
				clips.assertString("(esplicito si)");
				clips.assertString("(leggero si)");
				clips.assertString("(serie si)");
			}
			
			String gen = genere.getValue();
			
			switch(gen){
			
			case "Avventura":
				clips.assertString("(genere avventura)");
				break;
			case "Storico":
				clips.assertString("(genere storico)");
			case "Sociale":
				clips.assertString("(genere sociale)");
				break;
			case "Psicologico":
				clips.assertString("(genere psicologico)");
				break;
			case "Fantastico":
				clips.assertString("(genere fantastico)");
			    break;
			case "Giallo":
				clips.assertString("(genere giallo)");
				break;
			case "Gotico":
				clips.assertString("(genere nero)");
				break;
			case "Rosa":
				clips.assertString("(genere rosa)");
				break;
			case "Fantascienza":
				clips.assertString("(genere fantascienza)");
				break;
			}
			
			
			clips.eval("(save-facts Utenti/" + username.getText() + ")");
			Main.clips.eval("(load-facts Utenti/"+ username.getText() + ")");
			Stage stage = (Stage) username.getScene().getWindow();
			stage.close();
			
			}
		else{
			Alert alert = new Alert(AlertType.ERROR);
			alert.setTitle("Campo vuoto");
			alert.setHeaderText("Errore!");
			alert.setContentText("Prego, riempire tutti i campi e riprovare");

			alert.showAndWait();
		}
			
		}
		/**
		 * Funzione che gestisce le operazioni da effettuare alla pressione del tasto annulla
		 */
		@FXML
		public void annulla(){
			Stage stage = (Stage) username.getScene().getWindow();
			stage.close();
		}
	}


