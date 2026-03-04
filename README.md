# AI Traffic Signal Recognition with FPGA Display

This project demonstrates an end-to-end system that integrates **AI-based image classification with embedded hardware**. A web interface classifies traffic light images using a Roboflow model and sends the detected signal to an FPGA through UART. An Arduino acts as a bridge between the web interface and the FPGA, while the FPGA processes the input using Verilog logic and displays the result on 7-segment displays.

The goal of this project is to show how **cloud-based AI inference can interact with hardware systems in real time**.

---

## System Overview

The system consists of four main components:

1. **Web Interface**
   - Built using HTML, JavaScript, and TailwindCSS
   - Allows users to upload an image of a traffic signal
   - Sends the image to a Roboflow model for classification
   - Uses the Web Serial API to transmit the detected signal to Arduino

2. **AI Model (Roboflow)**
   - Classifies the traffic light into one of the following states:
     - Red
     - Yellow
     - Green
   - Returns the prediction with a confidence score

3. **Arduino (UART Bridge)**
   - Receives encoded data from the web interface over serial communication
   - Outputs the corresponding bits through GPIO pins connected to the FPGA

4. **FPGA (Display Logic)**
   - A Verilog module decodes the received signal
   - Displays the corresponding message on 7-segment displays

---

## Signal Encoding

| Traffic Light | Binary Code | Display Output |
|---------------|-------------|---------------|
| Red           | 0001        | STOP |
| Yellow        | 0010        | SLW |
| Green         | 0100        | GO |
| No Signal     | 1000        | ERR |

---

## Project Structure

| File | Description |
|-----|-------------|
| `index.html` | Web interface for uploading traffic light images, running AI classification, and sending the encoded result to Arduino via Web Serial. |
| `arduino_receiver.ino` | Arduino program that receives UART data from the browser and outputs the corresponding signals to FPGA GPIO pins. |
| `trafficLight.v` | Verilog module that decodes the 4-bit input signal and drives the 7-segment displays to show STOP, SLW, GO, or ERR. |
| `trafficLight_tb.v` | Verilog testbench used to simulate and verify the FPGA display logic. |
| `report/` | Project documentation describing the system architecture, implementation, and results. |


---

## How It Works

1. The user uploads a traffic light image using the web interface.
2. The image is sent to a Roboflow AI model for classification.
3. The detected class is converted into a 4-bit encoded signal.
4. The signal is transmitted via UART to the Arduino.
5. Arduino forwards the signal through GPIO pins to the FPGA.
6. The FPGA decodes the input and updates the 7-segment display.

---

## Technologies Used

- Roboflow (AI image classification)
- HTML / JavaScript / TailwindCSS
- Web Serial API
- Arduino
- Verilog
- FPGA

---
