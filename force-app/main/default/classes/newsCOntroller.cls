public with sharing class newsCOntroller {
    @AuraEnabled
    
    public static Map<String,Object> retrieveNews(String query) {
        HttpRequest httpRequest = new HttpRequest();
        httpRequest.setEndpoint('http://newsapi.org/v2/everything?q='+ query +'&apiKey=a83a5ccdef0341929323a6a12aa93cea');
        //httpRequest.setEndpoint('http://newsapi.org/v2/top-headlines?country=in&apiKey=a83a5ccdef0341929323a6a12aa93cea');
        //System.debug(query);
        httpRequest.setMethod('GET');

        Map<String,Object> newsJsonData =new Map<String,Object>();
        String strResponse = null;

        try{
            Http http = new Http();
            HttpResponse httpResponse = http.send(httpRequest);
            if(httpResponse.getStatusCode() == 200){
                strResponse = httpResponse.getBody();

            }else{
                throw new CalloutException(httpResponse.getBody());
            }
        } catch(Exception e){
            throw e;
        }

        if(!String.isBlank(strResponse)){
            newsJsonData = (Map<String,Object>)JSON.deserializeUntyped(strResponse);
             System.debug(newsJsonData);
        }
        if(!newsJsonData.isEmpty()){
            return newsJsonData;
        } else{
            return null;
        }
    }
}
