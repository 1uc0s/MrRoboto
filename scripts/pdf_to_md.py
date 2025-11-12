#!/usr/bin/env python3
"""
PDF to Markdown converter script.
Converts a PDF file to Markdown format using PyMuPDF (fitz).
"""

import sys
import os
import fitz  # PyMuPDF

def pdf_to_markdown(pdf_path, output_path=None):
    """
    Convert a PDF file to Markdown format.
    
    Args:
        pdf_path: Path to the input PDF file
        output_path: Path to the output Markdown file (optional)
    
    Returns:
        Path to the created Markdown file
    """
    if not os.path.exists(pdf_path):
        raise FileNotFoundError(f"PDF file not found: {pdf_path}")
    
    # Generate output path if not provided
    if output_path is None:
        base_name = os.path.splitext(os.path.basename(pdf_path))[0]
        output_dir = os.path.dirname(pdf_path)
        output_path = os.path.join(output_dir, f"{base_name}.md")
    
    # Open the PDF
    doc = fitz.open(pdf_path)
    
    markdown_content = []
    
    # Add title from PDF metadata or filename
    if doc.metadata.get('title'):
        markdown_content.append(f"# {doc.metadata['title']}\n")
    else:
        title = os.path.splitext(os.path.basename(pdf_path))[0]
        markdown_content.append(f"# {title}\n")
    
    # Add metadata if available
    if doc.metadata.get('author') or doc.metadata.get('subject'):
        markdown_content.append("## Document Information\n\n")
        if doc.metadata.get('author'):
            markdown_content.append(f"**Author:** {doc.metadata['author']}\n\n")
        if doc.metadata.get('subject'):
            markdown_content.append(f"**Subject:** {doc.metadata['subject']}\n\n")
        markdown_content.append("---\n\n")
    
    # Process each page
    for page_num in range(len(doc)):
        page = doc[page_num]
        
        # Add page header
        markdown_content.append(f"## Page {page_num + 1}\n\n")
        
        # Extract text blocks with formatting
        blocks = page.get_text("dict")
        
        for block in blocks["blocks"]:
            if "lines" in block:  # Text block
                for line in block["lines"]:
                    line_text = ""
                    for span in line["spans"]:
                        text = span["text"]
                        # Apply formatting based on font properties
                        if span.get("flags", 0) & 16:  # Bold
                            text = f"**{text}**"
                        if span.get("flags", 0) & 2:  # Italic
                            text = f"*{text}*"
                        line_text += text
                    
                    if line_text.strip():
                        markdown_content.append(f"{line_text}\n")
                    else:
                        markdown_content.append("\n")
                
                markdown_content.append("\n")
        
        markdown_content.append("\n---\n\n")
    
    doc.close()
    
    # Write to output file
    with open(output_path, 'w', encoding='utf-8') as f:
        f.write(''.join(markdown_content))
    
    return output_path

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python pdf_to_md.py <pdf_path> [output_path]")
        sys.exit(1)
    
    pdf_path = sys.argv[1]
    output_path = sys.argv[2] if len(sys.argv) > 2 else None
    
    try:
        result_path = pdf_to_markdown(pdf_path, output_path)
        print(f"Successfully converted PDF to Markdown: {result_path}")
    except Exception as e:
        print(f"Error converting PDF: {e}", file=sys.stderr)
        sys.exit(1)


