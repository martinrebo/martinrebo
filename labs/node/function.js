sexport function createConnection() {
  // A real implementation would actually connect to the server
  return {
    connect() {
      console.log('✅ Connecting...');
    },
    disconnect() {
      console.log('❌ Disconnected.');
    }
  };
}
 const connection = createConnection();
connection.connect();
const user = {
  name: 'Alice',
  greet: function () {
    const self = this.name; // Capture the context
    console.log(`Hi, I'm ${this.name}`);
  },
};