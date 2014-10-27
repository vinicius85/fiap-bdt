package com.scalable.thoughts.neo4j;


public class RelationshipTest {

	public static void main(String[] args) {

		String node1 = "CREATE (metro:Metro { nome:'Faria Lima' , desc:'estacao de metro' })";
		String node2 = "CREATE (avenida:Avenida { nome:'Faria Lima', lado:'par' })";
		String node3 = "CREATE (rua:Rua { nome:'dos Pinheiros' })";
		String node4 = "CREATE (banco:Banco { nome:'Itau', numero:1346 })";
		String node5 = "CREATE (rua2:Rua { nome:'Diogo Moreira' })";
		String node6 = "CREATE (edificio:Edificio { nome:'Universo Online' , numero:1384 })";

		String rel1 = "CREATE (metro)-[:" + Relationship.SIGA_EM_FRENTE + "]->(avenida)";
		String rel2 = "CREATE (avenida)-[:" + Relationship.ATRAVESSE + "]->(rua)";
		String rel3 = "CREATE (rua)-[:" + Relationship.SIGA_EM_FRENTE + "]->(avenida)";
		String rel4 = "CREATE (avenida)-[:" + Relationship.SIGA_EM_FRENTE + "]->(banco)";
		String rel5 = "CREATE (banco)-[:" + Relationship.VIRE_A_DIREITA + "]->(rua2)";
		String rel6 = "CREATE (rua2)-[:" + Relationship.VIRE_A_ESQUERDA + "]->(avenida)";
		String rel7 = "CREATE (avenida)-[:" + Relationship.CHEGUE_AO_DESTINO + "]->(edificio)";

		insert(node1);
		insert(node2);
		insert(node3);
		insert(node4);
		insert(node5);
		insert(node6);

		insert(rel1);
		insert(rel2);
		insert(rel3);
		insert(rel4);
		insert(rel5);
		insert(rel6);
		insert(rel7);

	}

	private static void insert(String node) {
		System.out.println(node);
	}

}
