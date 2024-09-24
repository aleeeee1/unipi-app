#!/bin/bash

CURRENT_DIR=$(pwd)
APP_NAME="Runner"

BUILD_DIR="${CURRENT_DIR}/build/ios/iphoneos"
WORKING_DIR="${CURRENT_DIR}/build/ios/tmp"
PAYLOAD_DIR="${WORKING_DIR}/Payload"

OUT_DIR="${CURRENT_DIR}/build/ios/out"
IPA_NAME="unipi_orario.ipa"
ZIP_NAME="Payload.zip"

function build_ios {
	echo "Building Flutter iOS release..."
	flutter build ios --release
}

function prepare_payload {
	echo "Preparing Payload directory..."
	if [ -d "$PAYLOAD_DIR" ]; then
		rm -rf "$PAYLOAD_DIR"
	fi
	mkdir -p "$PAYLOAD_DIR"
	cp -R "${BUILD_DIR}/${APP_NAME}.app" "$PAYLOAD_DIR"
}

function create_ipa {
	echo "Creating IPA file..."
	if [ ! -d "$OUT_DIR" ]; then
		mkdir -p "$OUT_DIR"
	fi
	(cd "$WORKING_DIR" && zip -r "$ZIP_NAME" "Payload" >/dev/null)
	mv "${WORKING_DIR}/${ZIP_NAME}" "${OUT_DIR}/${IPA_NAME}"
	rm -rf "$WORKING_DIR"
	echo "${OUT_DIR}/${IPA_NAME} created successfully."
}

function clean {
	echo "Cleaning up..."
	rm -rf "$BUILD_DIR" "$WORKING_DIR" "${OUT_DIR}/${IPA_NAME}"
}

function main {
	build_ios
	prepare_payload
	create_ipa
}

if [[ $1 == "clean" ]]; then
	clean
else
	main
fi
