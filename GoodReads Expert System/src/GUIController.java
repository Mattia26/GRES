import java.net.URL;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.ResourceBundle;

import javafx.collections.FXCollections;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.control.ListView;
import javafx.scene.control.RadioButton;
import net.sf.clipsrules.jni.PrimitiveValue;

public class GUIController implements Initializable{
	
	@FXML
	private RadioButton violenzaS;
	@FXML
	private RadioButton violenzaN;
	@FXML
	private RadioButton esplicitoS;
	@FXML
	private RadioButton esplicitoN;
	@FXML
	private RadioButton lungoS;
	@FXML
	private RadioButton lungoN;
	@FXML
	private RadioButton lungoI;
	@FXML
	private RadioButton divertenteS;
	@FXML
	private RadioButton divertenteN;
	@FXML
	private RadioButton divertenteI;
	@FXML
	private RadioButton serieS;
	@FXML
	private RadioButton serieN;
	@FXML
	private RadioButton serieI;
	@FXML
	private RadioButton leggeroS;
	@FXML
	private RadioButton leggeroN;
	@FXML
	private RadioButton leggeroI;
	@FXML
	private RadioButton imprevedibileS;
	@FXML
	private RadioButton imprevedibileN;
	@FXML
	private RadioButton imprevedibileI;
	@FXML
	private RadioButton intensoS;
	@FXML
	private RadioButton intensoN;
	@FXML
	private RadioButton intensoI;
	@FXML
	private ListView lista;
	
	public void initialize(URL arg0, ResourceBundle arg1){
		
		if(DefaultChoises.getViolento().equals("sì"))
			violenzaS.setSelected(true);
		else{
			violenzaN.setSelected(true);
			violenzaN.setDisable(true);
			violenzaS.setDisable(true);
		}
		
		if(DefaultChoises.getEsplicito().equals("sì"))
			esplicitoS.setSelected(true);
		else{
			esplicitoN.setSelected(true);
			esplicitoN.setDisable(true);
			esplicitoS.setDisable(true);
		}
		
		switch(DefaultChoises.getLungo()){
		case "sì":
			lungoS.setSelected(true);
			break;
		case "no":
			lungoN.setSelected(true);
			break;
		case "indifferente":
			lungoI.setSelected(true);
		}
		
		switch(DefaultChoises.getDivertente()){
		case "sì":
			divertenteS.setSelected(true);
			break;
		case "no":
			divertenteN.setSelected(true);
			break;
		case "indifferente":
			divertenteI.setSelected(true);
			break;
		}
		
		switch(DefaultChoises.getImprevedibile()){
		case "sì":
			imprevedibileS.setSelected(true);
			break;
		case "no":
			imprevedibileN.setSelected(true);
			break;
		case "indifferente":
			imprevedibileI.setSelected(true);
			break;
		}
		
		switch(DefaultChoises.getLeggero()){
		case "sì":
			leggeroS.setSelected(true);
			break;
		case "no":
			leggeroN.setSelected(true);
			break;
		case "indifferente":
			leggeroI.setSelected(true);
			break;
		}
		
		switch(DefaultChoises.getSerie()){
		case "sì":
			serieS.setSelected(true);
			break;
		case "no":
			serieN.setSelected(true);
			break;
		case "indifferente":
			serieI.setSelected(true);
			break;
		}
	}
		
	
		
		
		
	
	
	@FXML
	public void conferma(){
		
		if((violenzaS.isSelected() || violenzaN.isSelected()) && (esplicitoS.isSelected() || esplicitoN.isSelected())
				&& (lungoS.isSelected() || lungoN.isSelected() || lungoI.isSelected())
				&& (divertenteS.isSelected() || divertenteN.isSelected() || divertenteI.isSelected())
				&& (serieS.isSelected() || serieN.isSelected() || serieI.isSelected())
				&& (leggeroS.isSelected() || leggeroN.isSelected() || leggeroI.isSelected())
				&& (imprevedibileS.isSelected() || imprevedibileN.isSelected() || imprevedibileI.isSelected())
				&& (intensoS.isSelected() || intensoN.isSelected() || intensoI.isSelected())){
			
			Main.clips.reset();
			Main.clips.assertString("(interfaccia)");
			
			if(violenzaS.isSelected())
				Main.clips.assertString("(violento si)");
			else
				Main.clips.assertString("(violento no)");
			
			if(esplicitoS.isSelected())
				Main.clips.assertString("(esplicito si)");
			else
				Main.clips.assertString("(esplicito no)");
			
			if(lungoS.isSelected())
				Main.clips.assertString("(lungo si)");
			else if(lungoN.isSelected())
				Main.clips.assertString("(lungo no)");
			else
				Main.clips.assertString("(lungo indifferente)");
			
			if(divertenteS.isSelected())
				Main.clips.assertString("(divertente si)");
			else if(divertenteN.isSelected())
				Main.clips.assertString("(divertente no)");
			else
				Main.clips.assertString("(divertente indifferente)");
			
			if(serieS.isSelected())
				Main.clips.assertString("(serie si)");
			else if(serieN.isSelected())
				Main.clips.assertString("(serie no)");
			else
				Main.clips.assertString("(serie indifferente)");
			
			if(leggeroS.isSelected())
				Main.clips.assertString("(leggero si)");
			else if(leggeroN.isSelected())
				Main.clips.assertString("(leggero no)");
			else
				Main.clips.assertString("(leggero indifferente)");
			
			if(imprevedibileS.isSelected())
				Main.clips.assertString("(imprevedibile si)");
			else if(imprevedibileN.isSelected())
				Main.clips.assertString("(imprevedibile no)");
			else 
				Main.clips.assertString("(imprevedibile indifferente)");
			
			if(intensoS.isSelected())
				Main.clips.assertString("(intenso si)");
			else if(intensoN.isSelected())
				Main.clips.assertString("(intenso no)");
			else
				Main.clips.assertString("(intenso indifferente)");
			
			Main.clips.run();
			ArrayList<String> titoli = Utility.getTitoli();
			
			lista.setItems((FXCollections.observableArrayList(titoli)));
			
			
			
		}
		
		else{
			Alert alert = new Alert(AlertType.WARNING);
			alert.setTitle("Attenzione");
			alert.setHeaderText("Compilare tutti i campi!");

			alert.showAndWait();

		}
		
	}
	
	@FXML
	public void aiuto0(){
		Utility.messaggio("Aiuto", "Per utilizzare il sistema scegli gli aggettivi"
				+ "che più si addicono ai tuoi gusti,\n la scelta  'Entrambi' implica che"
				+ "ti è indifferente una caratteristica o l'altra.\n Una volta selezionato"
				+ "un elemento per ogni riga premi il tasto conferma (oppure premi spazio)\n"
				+ "e sulla destra vedrai apparire i titoli dei romanzi che l'applicazione"
				+ "ha scelto per te\n fiancheggiati da un punteggio che va da 0 a 5."
				+ "Premere OK per continuare.");
	}
	
	@FXML
	public void help4(){
		Utility.messaggio("Divertente/Serio", "Un romanzo divertente contiene situazioni esilaranti e generalmente\n" 
	       + "ha un tono goliardico e leggero, un romanzo serio invece ha una trama\n"
	       + "creata con lo scopo di raccontare avvenimenti più reali che suscitano\n"
	       + "più che un sorriso, una riflessione. Premere OK per continuare.");
	}
	
	@FXML
	public void help5(){
		Utility.messaggio("Intenso/Riflessivo", "Un libro intenso si concentra principalmente sulla trama e cattura il lettore in un\n" 
				+ "vortice di eventi di solito senza o con pochissimi momenti di respiro; un romanzo riflessivo\n"
				+ "invece, si sofferma spesso sugli eventi per analizzare i pensieri e le emozioni dei personaggi,\n" 
				+ "si tratta di un tipo di scrittura più descrittiva e lenta che porta appunto a riflettere.\n"
				+ "Premere OK per continuare" );
	}
	@FXML
	public void help7(){
		Utility.messaggio("Leggero/Impegnativo","Un romanzo leggero è più facile da leggere, il linguaggio è più semplice e la trama\n"
				 + "non troppo complicata, un romanzo impegnativo al contrario, necessita una discreta quantità\n"  
					+ "di concentrazione per essere letto e apprezzato.Premere INVIO per continuare");
	}
	@FXML
	public void help8(){
		Utility.messaggio("Imprevedibile/Tranquillo", "Un romanzo imprevedibile ha una trama ricca di colpi di scena, i personaggi\n"
				+ "evolvono in maniera più brusca e veloce rispetto a un romanzo con una trama più\n"
				+ "piatta che si concentra sull'aspetto caratteriale dei personaggi e sulla psicologia delle\n"
				+ "situazioni raccontate.Premere OK per continuare");
	}
	
	@FXML
	public void rating(){
		Utility.messaggio("Ratings", "I punteggi qui mostrati vengono da www.goodreads.com");
	}
	

}
