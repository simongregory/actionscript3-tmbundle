#!/bin/bash

echo "Work in progress. Please complete!"
exit 206;

asdoc -source-path "uk" \
	  -doc-sources "uk/." \
	  -main-title "Project Documentation" \
	  -window-title "Project Docs" \
	  -package uk.co.client.core "Core" \
	  -output "../asdocs"
