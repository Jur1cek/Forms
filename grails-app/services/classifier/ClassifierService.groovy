package classifier

import grails.transaction.Transactional
import groovyx.net.http.HTTPBuilder

import static com.xlson.groovycsv.CsvParser.parseCsv
import groovyx.net.http.ParserRegistry

@Transactional
class ClassifierService {

	void updateClassifiers() {
		def http = new HTTPBuilder('http://ciselniky.portalvs.sk')
		http.parser.'text/csv' = { resp ->
			return parseCsv( new InputStreamReader( resp.entity.content,
			ParserRegistry.getCharset( resp ) ), separator: ';' )
		}

		for (classId in 1..14) {
			updateClassifier(http, classId as String)
		}
	}

	void updateClassifier(def http, String classId) {
		http.get( path : "/classifier/download-utf/basic/$classId",
		contentType : 'text/csv' ) { resp, csv ->

			assert resp.statusLine.statusCode == 200

			def items = new HashMap()
			for(line in csv) {
				items.put(line.getAt("kód"), line.getAt("názov"))
			}

			Classifier classifier = Classifier.findByClassId(classId)

			if (classifier) {
				classifier.items = items;
			} else {
				classifier = new Classifier(name: classId, classId: classId, items: items)
			}

			classifier.save()
		}
	}
}