//The MIT License (MIT)
//
//Copyright (c) 2017 Caleb Kleveter
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//SOFTWARE.

public class SMRenderer: Renderer {
    private var renderers: [NodeRenderer] = []
    
    public func addRenderer(_ renderer: NodeRenderer) {
        self.renderers.append(renderer)
    }
    
    public func addRenderers(_ newRenderers: [NodeRenderer]) {
        self.renderers.append(contentsOf: newRenderers)
    }
    
    public func render(_ ast: [Node]) -> String {
        var html = ""
        
        for node in ast {
            let nodeMetadata: NodeMetadata
            switch node {
            case let .null(metadata: metadata): nodeMetadata = metadata
            case let .string(value: _, metadata: metadata): nodeMetadata = metadata
            case let .array(values: _, metadata: metadata): nodeMetadata = metadata
            case let .object(values: _, metadata: metadata): nodeMetadata = metadata
            }
            
            if let renderer = self.renderers.filter({ (renderer) -> Bool in
                return String.init(describing: renderer) == nodeMetadata.rendererName
            }).first {
                html.append(renderer.render(node))
            }
        }
        
        return html
    }
}