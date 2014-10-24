package com.scalable.thoughts.ontology;

import com.hp.hpl.jena.ontology.Individual;
import com.hp.hpl.jena.ontology.OntClass;
import com.hp.hpl.jena.ontology.OntModel;
import com.hp.hpl.jena.ontology.Ontology;
import com.hp.hpl.jena.rdf.model.ModelFactory;

public class Maps {

	private String baseURI = "http://fiap.com.br/5bdt/maps-ontology";

	private String namespace = baseURI + "#";

	public Ontology buildMapsOntology() {

		OntModel ontModel = ModelFactory.createOntologyModel();

		OntClass via = ontModel.createClass(namespace + "Via");
		OntClass rua = ontModel.createClass(namespace + "Rua");
		OntClass avenida = ontModel.createClass(namespace + "Avenida");
		via.addSubClass(rua);
		via.addSubClass(avenida);

		OntClass ponto = ontModel.createClass(namespace + "Ponto");
		OntClass edificio = ontModel.createClass(namespace + "Edificio");
		OntClass terminal = ontModel.createClass(namespace + "Terminal");
		ponto.addSubClass(terminal);
		ponto.addSubClass(edificio);

		OntClass direcao = ontModel.createClass(namespace + "Direcao");
		OntClass sigaEmFrente = ontModel.createClass(namespace + "SigaEmFrente");
		OntClass entreADireita = ontModel.createClass(namespace + "EntreADireita");
		OntClass entreAEsquerda = ontModel.createClass(namespace + "EntreAEsquerda");
		direcao.addSubClass(sigaEmFrente);
		direcao.addSubClass(entreADireita);
		direcao.addSubClass(entreAEsquerda);

		OntClass coordenadas = ontModel.createClass(namespace + "Coordenadas");
		OntClass aPartirDe = ontModel.createClass(namespace + "APartirDe");
		OntClass chegueNoDestino = ontModel.createClass(namespace + "ChegueNoDestino");
		coordenadas.addSubClass(aPartirDe);
		coordenadas.addSubClass(chegueNoDestino);

		Ontology ontology = ontModel.createOntology(baseURI);

		return ontology;
	}

	public Individual buildIndividual(Ontology ontology, String clazz, String instance) {

		OntModel model = ontology.getOntModel();
		OntClass ontClass = model.getOntClass(namespace + clazz);
		Individual indInstance = ontClass.createIndividual(namespace + instance);

		return indInstance;

	}

	public static void main(String[] args) {

		Maps maps = new Maps();

		Ontology ontology = maps.buildMapsOntology();

		System.out.println("Nome da ontologia: " + ontology.getURI());

		ontology.getOntModel().write(System.out, "RDF/XML-ABBREV");

		System.out.println(maps.buildIndividual(ontology, "Avenida", "Faria Lima"));
	}
}
