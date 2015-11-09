package classifier

import grails.transaction.Transactional
import groovyx.net.http.HTTPBuilder
import groovyx.net.http.ParserRegistry

import static com.xlson.groovycsv.CsvParser.parseCsv

@Transactional
class ClassifierService {

    void updateClassifiers() {
        def http = new HTTPBuilder('http://ciselniky.portalvs.sk')
        http.parser.'text/csv' = { resp ->
            return parseCsv(new InputStreamReader(resp.entity.content,
                    ParserRegistry.getCharset(resp)), separator: ';')
        }

        def classIds = ['university', 'faculty', 'workplace', 'field_of_study', 'degree', 'sp_language', 'study_program', 'study_form', 'study_level', 'sp_subject']

        for (classId in classIds) {
            updateClassifier(http, classId)
        }
    }

    void updateClassifier(def http, String classId) {
        http.get(path: "/classifier/download-utf/basic/$classId", query: [no_translate: 1, only_valid: 1],
                contentType: 'text/csv') { resp, csv ->

            assert resp.statusLine.statusCode == 200
            assert csv.hasNext()

            Classifier classifier = Classifier.findByClassId(classId)

            if (classifier)
                classifier.delete()

            classifier = new Classifier(name: classId, classId: classId)

            for (line in csv) {
                ClassifierLine classifierLine = new ClassifierLine();

                for (column in line.columns) {
                    classifierLine.addToClassifierItems(new ClassifierItem(name: column.key, value: line.values[column.value]))
                }

                classifier.addToLines(classifierLine);
            }

            classifier.save()
        }
    }
}