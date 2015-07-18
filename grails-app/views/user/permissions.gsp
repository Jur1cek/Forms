<%--
  Created by IntelliJ IDEA.
  User: Jur1cek
  Date: 04/03/15
  Time: 21:42
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Správa používateľov</title>
    <meta name="layout" content="main">
</head>

<body>
<div class="page-header">
    <h3>Správa používateľov</h3>
</div>

<div class="row">
    <div class="col-md-4">
        <input id="user_tree_search" type="text" class="form-control" placeholder="Hľadať..."
               style="margin-bottom: 10px">

        <div id="user_tree">
            <ul>
                <li id="${userInstance.id}">${userInstance.userProfile.name}
                </li>
            </ul>
        </div>

        <div style="margin-top: 20px;">
            <a href="#" onclick="loadNew();"
               class="btn btn-success">Nový</a>
        </div>
    </div>

    <div class="col-md-8" id="ajax_area">
    </div>
</div>
<script>
    function loadNew() {
        id = $("#user_tree").jstree("get_selected").id;
        $('#ajax_area').load('${createLink(action: 'create')}' + '/' + id);
    }
    $(function () {
        $('#user_tree').jstree({
            "core": {
                "multiple": false,
                'data': {
                    'url': "${createLink(action: 'getChildrenJSON', id:(userInstance.id))}"
                }
            },
            'contextmenu': {
                'items': function (node) {
                    return {
                        "Create": {
                            "label": "Nový",
                            "action": function (obj) {
                                $('#ajax_area').load("${createLink(action: 'create')}" + '/' + node.id);
                            },
                            "icon": "fa fa-plus"
                        },
                        "Edit": {
                            "label": "Upraviť",
                            "action": function (obj) {
                                $('#ajax_area').load("${createLink(action: 'update')}" + '/' + node.id);
                            },
                            "icon": "fa fa-pencil"
                        }
                    };
                }
            },
            "plugins": ["contextmenu", "search", "state"]
        }).on('changed.jstree', function (e, data) {

            if (typeof data.node !== 'undefined') {
                $('#ajax_area').load("${createLink(action: 'show')}" + '/' + data.node.id + "?updateTree=true");
            }
        });
        var to = false;
        $('#user_tree_search').keyup(function () {
            if (to) {
                clearTimeout(to);
            }
            to = setTimeout(function () {
                var v = $('#user_tree_search').val();
                $('#user_tree').jstree(true).search(v);
            }, 250);
        });
    });
</script>
</body>
</html>