package com.scalable.thoughts.ontology;

import java.util.ArrayList;
import java.util.List;

import com.hp.hpl.jena.ontology.DatatypeProperty;
import com.hp.hpl.jena.ontology.Individual;
import com.hp.hpl.jena.ontology.OntClass;
import com.hp.hpl.jena.ontology.OntModel;
import com.hp.hpl.jena.ontology.Ontology;
import com.hp.hpl.jena.rdf.model.ModelFactory;
import com.hp.hpl.jena.rdf.model.Property;
import com.hp.hpl.jena.rdf.model.Statement;

public class Maps {

	private String namespace = "http://fiap.com.br/5bdt/maps/";

	public Ontology buildMapsOntology() {

		OntModel ontModel = ModelFactory.createOntologyModel();

		OntClass via = ontModel.createClass(namespace + "Via");
		OntClass rua = ontModel.createClass(namespace + "Rua");
		OntClass avenida = ontModel.createClass(namespace + "Avenida");
		via.addSubClass(rua);
		via.addSubClass(avenida);

		OntClass ponto = ontModel.createClass(namespace + "Ponto");
		OntClass edificio = ontModel.createClass(namespace + "Edificio");
		OntClass terminal = ontModel.createClass(namespace + "Metro");
		OntClass banco = ontModel.createClass(namespace + "Banco");
		ponto.addSubClass(terminal);
		ponto.addSubClass(edificio);
		ponto.addSubClass(banco);

		OntClass direcao = ontModel.createClass(namespace + "Direcao");
		DatatypeProperty siga = ontModel.createDatatypeProperty(namespace + "Siga em frente");
		DatatypeProperty direita = ontModel.createDatatypeProperty(namespace + "Vire a direita");
		DatatypeProperty esquerda = ontModel.createDatatypeProperty(namespace + "Vire a esquerda");
		DatatypeProperty atravesse = ontModel.createDatatypeProperty(namespace + "Atravesse");
		DatatypeProperty destino = ontModel.createDatatypeProperty(namespace + "Chegue ao destino");
		siga.setDomain(direcao);
		direita.setDomain(direcao);
		esquerda.setDomain(direcao);
		atravesse.setDomain(direcao);
		destino.setDomain(direcao);

		Ontology ontology = ontModel.createOntology(namespace);

		return ontology;
	}

	public Individual buildIndividual(Ontology ontology, String clazz, String instance) {

		OntModel model = ontology.getOntModel();
		OntClass ontClass = model.getOntClass(namespace + clazz);
		Individual indInstance = ontClass.createIndividual(namespace + clazz + "#" + instance);

		return indInstance;

	}

	public List<Statement> buildTriplets(Ontology ontology) {

		List<Statement> statements = new ArrayList<Statement>();

		OntModel ontModel = ontology.getOntModel();

		Individual sujeito1 = buildIndividual(ontology, "Metro", "Faria Lima");
		Property verbo1 = ontModel.getProperty(namespace + "Siga em frente");
		Individual objeto1 = buildIndividual(ontology, "Avenida", "Faria Lima");
		statements.add(ontModel.createStatement(sujeito1, verbo1, objeto1));

		Individual sujeito2 = buildIndividual(ontology, "Avenida", "Faria Lima");
		Property verbo2 = ontModel.getProperty(namespace + "Atravesse");
		Individual objeto2 = buildIndividual(ontology, "Rua", "dos Pinheiros");
		statements.add(ontModel.createStatement(sujeito2, verbo2, objeto2));

		Individual sujeito3 = buildIndividual(ontology, "Avenida", "Faria Lima");
		Property verbo3 = ontModel.getProperty(namespace + "Siga em frente");
		Individual objeto3 = buildIndividual(ontology, "Banco", "Itau");
		statements.add(ontModel.createStatement(sujeito3, verbo3, objeto3));

		Individual sujeito4 = buildIndividual(ontology, "Banco", "Itau");
		Property verbo4 = ontModel.getProperty(namespace + "Vire a direita");
		Individual objeto4 = buildIndividual(ontology, "Rua", "Diogo Moreira");
		statements.add(ontModel.createStatement(sujeito4, verbo4, objeto4));

		Individual sujeito5 = buildIndividual(ontology, "Rua", "Diogo Moreira");
		Property verbo5 = ontModel.getProperty(namespace + "Vire a esquerda");
		Individual objeto5 = buildIndividual(ontology, "Avenida", "Faria Lima");
		statements.add(ontModel.createStatement(sujeito5, verbo5, objeto5));

		Individual sujeito6 = buildIndividual(ontology, "Avenida", "Faria Lima");
		Property verbo6 = ontModel.getProperty(namespace + "Chegue ao Destino");
		Individual objeto6 = buildIndividual(ontology, "Edificio", "Universo Online");
		statements.add(ontModel.createStatement(sujeito6, verbo6, objeto6));

		return statements;

	}

	public static void main(String[] args) {

		Maps maps = new Maps();

		Ontology ontology = maps.buildMapsOntology();

		System.out.println("Nome da ontologia: " + ontology.getURI());

		ontology.getOntModel().write(System.out, "RDF/XML-ABBREV");

		System.out.println("\n");

		List<Statement> statements = maps.buildTriplets(ontology);

		for (Statement statement : statements) {
			System.out.println(statement);
		}

	}
}
