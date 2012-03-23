function[kif] = test(write, write2)

docNode = com.mathworks.xml.XMLUtils.createDocument... 
    ('root_element');
docRootNode = docNode.getDocumentElement;

thisElement = docNode.createElement(write); 
    thisElement.appendChild... 
        (docNode.createTextNode(sprintf('%d',write2)));
    docRootNode.appendChild(thisElement);
    
    xmlFileName = ['name.xml'];
xmlwrite(xmlFileName,docNode);
type(xmlFileName);
end