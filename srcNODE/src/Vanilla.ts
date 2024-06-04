/* Copyright 2024 "Holloway" Chew; Kean Ho <hello@hollowaykeanho.com>
 *
 *
 * Licensed under the Apache License; Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License. You may obtain a copy of
 * the License at:
 *
 *                  http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing; software
 * distributed under the License is distributed on an "AS IS" BASIS; WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND; either express or implied. See the
 * License for the specific language governing permissions and limitations under
 * the License.
 */




// common errors
export const OK = 0;
export const BAD_EXEC = 1;
export const BAD_DESCRIPTOR = 2;
export const BAD_EXCHANGE = 3;
export const BAD_MOUNT = 4;
export const BAD_PIPE = 5;
export const BAD_REQUEST = 6;
export const BAD_STREAM_PIPE = 7;
export const CANCELED = 8;
export const CLEANING_REQUIRED = 9;
export const DEADLOCK = 10;
export const EXPIRED = 11;
export const ILLEGAL_BYTE_SEQUENCE = 12;
export const ILLEGAL_SEEK = 13;
export const INVALID_ARGUMENT = 14;
export const IS_EMPTY = 15;
export const MAXED_EXCHANGE = 16;
export const MAXED_QUOTA = 17;
export const MISSING_LOCK = 18;
export const NOT_EMPTY = 19;
export const NOT_PERMITTED = 20;
export const NOT_POSSIBLE = 21;
export const NOT_POSSIBLE_BY_RFKILL = 22;
export const NOT_RECOVERABLE = 23;
export const OUT_OF_RANGE = 24;
export const PERMISSION_DENIED = 25;
export const TIMEOUT = 26;
export const TOO_MANY_READ = 27;
export const TOO_MANY_LOOP = 28;
export const TOO_MANY_REFERENCES = 29;
export const TOO_MANY_LINK = 30;
export const TRY_AGAIN = 31;
export const UNSUPPORTED = 32;
export const WOULD_BLOCK = 33;

// lifecycle states
export const RESTART = 34;
export const RESUME = 35;
export const SHUTDOWN = 36;
export const SLEEP = 37;
export const STALLED = 38;
export const STANDBY = 39;
export const PROGRESS_SCHEDULED = 40;
export const PROGRESS_ALREADY_EXECUTING = 41;
export const PROGRESS_EXECUTING = 42;
export const PROGRESS_COMPLETED = 43;

// tri-tier inter-package communications
export const LV1_NOT_SYNC = 44;
export const LV1_PAUSED = 45;
export const LV1_RESET = 46;
export const LV2_NOT_SYNC = 47;
export const LV2_PAUSED = 48;
export const LV2_RESET = 49;
export const LV3_NOT_SYNC = 50;
export const LV3_PAUSED = 51;
export const LV3_RESET = 52;

// data (input/output parameters; type; etc)
export const DATA_BAD = 53;
export const DATA_EMPTY = 54;
export const DATA_INVALID = 55;
export const DATA_IS_UNIQUE = 56;
export const DATA_MISSING = 57;
export const DATA_NOT_UNIQUE = 58;
export const DATA_OVERFLOW = 59;
export const DATA_REMOVED = 60;
export const DATA_TOO_LONG = 61;
export const DATA_MISMATCHED = 62;

// entity (device; file; directory; object; etc)
export const ENTITY_BAD = 63;
export const ENTITY_BUSY = 64;
export const ENTITY_DEAD = 65;
export const ENTITY_EXISTS = 66;
export const ENTITY_FAULTY = 67;
export const ENTITY_MISSING = 68;
export const ENTITY_MISSING_CHILD = 69;
export const ENTITY_OUT_OF_BUFFER = 70;
export const ENTITY_POISONED = 71;
export const ENTITY_TOO_BIG = 72;
export const ENTITY_TOO_MANY_OPENED = 73;
export const ENTITY_UNATTACHED = 74;
export const ENTITY_IS_NOT_DIRECTORY = 75;
export const ENTITY_IS_NOT_FILE = 76;
export const ENTITY_IS_NOT_LINK = 77;
export const ENTITY_IS_NOT_SOCKET = 78;
export const ENTITY_REMOTE_CHANGED = 79;
export const ENTITY_REMOTE_ERROR = 80;
export const ENTITY_REMOTE_IO = 81;
export const ENTITY_MISSING_STREAMABLE_RESOURCES = 82;
export const ENTITY_NOT_STREAMABLE = 83;
export const ENTITY_STREAMABLE = 84;
export const ENTITY_A_TYPEWRITER = 85;
export const ENTITY_NOT_A_TYPEWRITER = 86;
export const ENTITY_BAD_DESCRIPTOR = 87;
export const ENTITY_FILETABLE_OVERFLOW = 88;

// key (cryptography)
export const KEY_BAD = 89;
export const KEY_DESTROYED = 90;
export const KEY_EXPIRED = 91;
export const KEY_MISSING = 92;
export const KEY_REJECTED = 93;
export const KEY_REVOKED = 94;

// library
export const LIBRARY_BAD = 95;
export const LIBRARY_CORRUPTED = 96;
export const LIBRARY_EXEC_FAILED = 97;
export const LIBRARY_MAXED = 98;
export const LIBRARY_MISSING = 99;

// network
export const NETWORK_BAD = 100;
export const NETWORK_BAD_AD = 101;
export const NETWORK_DOWN = 102;
export const NETWORK_NOT_CONNECTED = 103;
export const NETWORK_RESET = 104;
export const NETWORK_RFS = 105;
export const NETWORK_UNREACHABLE = 106;

export const NETWORK_HOST_DOWN = 107;
export const NETWORK_HOST_UNREACHABLE = 108;
export const NETWORK_SOCKET_UNSUPPORTED = 109;

export const NETWORK_ADDRESS_IN_USE = 110;
export const NETWORK_ADDRESS_UNAVAILABLE = 111;

export const NETWORK_CONN_ABORTED = 112;
export const NETWORK_CONN_IS_CONNECTED = 113;
export const NETWORK_CONN_MISSING_DEST_ADDRESS = 114;
export const NETWORK_CONN_MULTIHOP = 115;
export const NETWORK_CONN_NOT_CONNECTED = 116;
export const NETWORK_CONN_REFUSED = 117;
export const NETWORK_CONN_RESET = 118;

export const NETWORK_PAYLOAD_BAD = 119;
export const NETWORK_PAYLOAD_EMPTY = 120;
export const NETWORK_PAYLOAD_MISSING = 121;
export const NETWORK_PAYLOAD_TOO_LONG = 122;

// protocol
export const PROTOCOL_ADDRESS_UNSUPPORTED = 123;
export const PROTOCOL_BAD = 124;
export const PROTOCOL_FAMILY_UNSUPPORTED = 125;
export const PROTOCOL_MISSING = 126;
export const PROTOCOL_UNSUPPORTED = 127;

// system (e.g. os; interactable system)
export const SYSTEM_BAD_IO = 128;
export const SYSTEM_DEVICE_CROSS_LINK = 129;
export const SYSTEM_INTERRUPT_CALL = 130;
export const SYSTEM_INVALID = 131;
export const SYSTEM_MISSING_BLOCK_DEVICE = 132;
export const SYSTEM_MISSING_DEVICE = 133;
export const SYSTEM_MISSING_IO = 134;
export const SYSTEM_MISSING_PROCESS = 135;
export const SYSTEM_OUT_OF_DOMAIN = 136;
export const SYSTEM_OUT_OF_MEMORY = 137;
export const SYSTEM_OUT_OF_SPACE = 138;
export const SYSTEM_READ_ONLY_FILESYSTEM = 139;

// user
export const USER_ACCESS_BANNED = 140;
export const USER_ACCESS_LOCKED = 141;
export const USER_ACCESS_NOT_VERIFIED = 142;
export const USER_ACCESS_REJECTED = 143;
export const USER_ACCESS_REVOKED = 144;
export const USER_ID_BAD = 145;
export const USER_ID_EXISTS = 146;
export const USER_ID_MISSING = 147;
export const USER_MFA_BAD = 148;
export const USER_MFA_EXPIRED = 149;
export const USER_MFA_MISSING = 150;
export const USER_PASSWORD_BAD = 151;
export const USER_PASSWORD_EXPIRED = 152;
export const USER_PASSWORD_MISSING = 153;
export const USER_KEYFILE_BAD = 154;
export const USER_KEYFILE_EXPIRED = 155;
export const USER_KEYFILE_MISSING = 156;
export const USER_ACCESS_TOKEN_BAD = 157;
export const USER_ACCESS_TOKEN_EXPIRED = 158;
export const USER_ACCESS_TOKEN_MISSING = 159;
export const USER_ACCESS_TOKEN_REVOKED = 160;
