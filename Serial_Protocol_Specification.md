# Serial Protocol Specification for Leaf LTHDMI88 AV Switch

## Overview
This document details the serial protocol used by the Leaf LTHDMI88 and LTHDMI88E AV Switch. The protocol is implemented over RS-232 communication and supports various commands for controlling video and audio routing through the matrix switch.

## Serial Communication Settings
- **Baud Rate**: 9600
- **Data Bits**: 8
- **Parity**: None
- **Stop Bits**: 1
- **Flow Control**: None

## Command Format
Each command consists of three bytes:
1. **Command Byte**: Specifies the operation to perform (32-255).
2. **Value Byte**: Provides additional data for the command (0-255).
3. **Zone Byte**: Identifies the target zone (0-255, typical range 0-7 for 8 zones).

### Example
A command to set a delay might look like this:
```
[Command Byte] [Value Byte] [Zone Byte]
```

## Response Format
The device responds with three-byte packets in the same format:
```
[Response ID] [Source] [Zone]
```

## Zone Banking
The device supports zone banking for installations with multiple units. The zone bank offset must be set to match the bank select dipswitch on the connected unit. The formula used is:
- Bank Select of X relates to Zone offset of X × 16
- Example: Bank Select of 9 relates to Zone offset of 144 (9 × 16)

## Supported Commands

| Command Byte | Description                          | Value Byte Range | Zone Byte Range | Notes |
|--------------|--------------------------------------|------------------|-----------------|-------|
| 52           | Query Video Zone                     | 0 (fixed)        | 0-255           | Queries the current state of a video zone |
| 53           | Zone Video Source Response           | Source (1-8)     | Zone (0-255)    | Response ID for video source status (not sent by controller) |
| 71           | Unlock/Turn Off Zone                 | 0 (fixed)        | 0-255           | Disconnects a zone from its source |
| 72           | Turn Zone On / Connect Source        | Source (1-8)     | 0-255           | Connects a source to a zone |
| 93           | Lock Zone to HDMI Source             | Source (1-8)     | 0-255           | Locks a zone to a specific HDMI source |
| 99           | Set RCA Output Delay                 | 0-255 (ms)       | 1-8             | Sets delay for RCA audio outputs |

## Command Descriptions

### 1. Query Video Zone
- **Command Byte**: 52
- **Value Byte**: 0 (fixed).
- **Zone Byte**: Target zone (0-255).
- **Description**: Queries the current state of a video zone.
- **Example**: Query Zone 7:
  ```
  [52] [0] [7]
  ```
- **Response**: The device will respond with command 53 containing the current source for the zone.

### 2. Zone Video Source Response
- **Response ID**: 53
- **Source Byte**: Current source (1-8, 0 if none).
- **Zone Byte**: Zone number (0-255).
- **Description**: Response sent by the device after a query to indicate the current source connected to a zone.
- **Example**: Zone 3 is connected to Source 2:
  ```
  [53] [2] [3]
  ```

### 3. Unlock/Turn Off Zone
- **Command Byte**: 71
- **Value Byte**: 0 (fixed).
- **Zone Byte**: Target zone (0-255).
- **Description**: Disconnects a zone from its source. This is the recommended way to turn off a zone.
- **Example**: Turn off Zone 5:
  ```
  [71] [0] [5]
  ```

### 4. Turn Zone On / Connect Source
- **Command Byte**: 72
- **Value Byte**: Source (1-8).
- **Zone Byte**: Target zone (0-255).
- **Description**: Connects a specific source to a zone, turning the zone on.
- **Example**: Connect Source 2 to Zone 6:
  ```
  [72] [2] [6]
  ```

### 5. Lock Zone to HDMI Source
- **Command Byte**: 93
- **Value Byte**: HDMI source (1-8).
- **Zone Byte**: Target zone (0-255).
- **Description**: Locks a zone to a specific HDMI source, preventing it from being changed.
- **Example**: Lock Zone 2 to Source 4:
  ```
  [93] [4] [2]
  ```

### 6. Set RCA Output Delay
- **Command Byte**: 99
- **Value Byte**: Delay in milliseconds (0-255).
- **Zone Byte**: Target zone (1-8).
- **Description**: Sets a delay for RCA audio outputs to help with audio/video synchronization.
- **Example**: Set a delay of 100ms for Zone 3:
  ```
  [99] [100] [3]
  ```

## Notes
- Commands are sent as raw bytes using the `string.char()` function in the driver.
- Zones and sources are typically indexed starting from 0 in the protocol, but presented to users as 1-8.
- The actual zone byte sent to the device includes the bank offset: `Zone + (8 * (Bank - 1))`.
- The device receives and sends data in triplets (3-byte packets).
- When a zone is locked to a source, attempts to change the source will be ignored by the device.

## Limitations
- Querying output status via the Control4 "QUERY_OUTPUT_STATUS" command is not fully implemented in the driver.
- The driver does not directly support the "ON" and "OFF" commands from Control4.
- Normal operation does not turn zones off. If Zone Off is required, it must be initiated using the Unlock Zone command (71).

## References
- **Driver Metadata**: The driver was certified on 5/8/2012 for Control4 software versions 2.1.1 and 2.2.1.
- **Supporting Hardware**: This protocol is used with Leaf LTHDMI88 and LTHDMI88E devices.