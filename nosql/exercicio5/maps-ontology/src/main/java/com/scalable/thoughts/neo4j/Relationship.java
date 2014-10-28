package com.scalable.thoughts.neo4j;

import org.neo4j.graphdb.RelationshipType;

public enum Relationship implements RelationshipType {

	SIGA_EM_FRENTE,
	VIRE_A_DIREITA,
	VIRE_A_ESQUERDA,
	ATRAVESSE,
	CHEGUE_AO_DESTINO

}
