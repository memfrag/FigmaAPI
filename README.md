
# Figma API

This is a Swift implementation of a [Figma REST API](https://www.figma.com/developers/api) client.

## License Info

This is free and unencumbered software released into the public domain. See `UNLICENSE` file for details.

## Usage

```swift
import FigmaAPI

let accessToken: String = "<Your Figma access token goes here>"

let api: FigmaAPI = FigmaAPIFactory.makeAPI(accessToken: accessToken)

let fileID: String = "<The ID of your figma file goes here>"

api.getFile(fileID) { result in
    switch result {
    case .success(let figmaFile):
        print("Downloaded the Figma document \(figmaFile.name).")
    case .failure(let error):
        dump(error)
    }
}
```

## File ID

The `fileID` used in the API is the long string of letters after `file/` and before the name of the Figma document in the Figma URL in the browser:

```text
https://www.figma.com/file/PiTSISPbDVQueOIDyepzTm/MyFigmaDoc?node-id=9%3A1
```
In this example, it's **`PiTSISPbDVQueOIDyepzTm`**

## API Request Tracing

In debug builds, the following enum is available:

```swift
public enum APILogType {
    case url
    case urlRequest
    case requestBody
    case responseCode
    case responseBody
}
```

To configure what should be logged:

```swift
FigmaAPI.apiLogTypes = [.url, .responseBody]
```

## Figma Node Inheritance Hierarchy

```text
FigmaNode
 ├─FigmaDocumentNode
 ├─FigmaCanvasNode
 ├─FigmaFrameNode
 │  ├─FigmaComponentNode
 │  ├─FigmaGroupNode
 │  └─FigmaInstanceNode
 ├─FigmaSliceNode
 └─FigmaVectorNode
    ├─FigmaBooleanOperationNode
    ├─FigmaEllipseNode
    ├─FigmaLineNode
    ├─FigmaRectangleNode
    ├─FigmaRegularPolygonNode
    ├─FigmaStarNode
    └─FigmaTextNode
```
