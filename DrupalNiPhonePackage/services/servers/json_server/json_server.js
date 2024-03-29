//$Id: json_server.js,v 1.1 2007/11/09 17:34:57 dmitrig01 Exp $
Drupal.toJson = function(v) {
  switch (typeof v) {
    case 'boolean':
      return v == true ? 'TRUE' : 'FALSE';
    case 'number':
      return v;
    case 'string':
      return '"'+ v +'"';
    case 'object':
      var output = "{";
      for(i in v) {
        output = output + i + ":" + Drupal.toJson(v[i]) + ",";
      }
      output = output + "}";
      return output;
    default:
      return 'null';
  }
};
Drupal.service = function(service_method, args, success) {
  args = $.extend({method: service_method}, args);
  args_done = {};
  for(i in args) {
    args_done[i] = Drupal.toJson(args[i]);
  }
  $.post(Drupal.settings.baseurl + "?q=services/json", args_done, function(unparsed_data) {
    parsed_data = Drupal.parseJson(unparsed_data);
    success(!parsed_data['#error'], parsed_data['#data']);
  });
};