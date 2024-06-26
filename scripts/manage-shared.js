const fs = require('fs-extra');
const path = require('path');

const action = process.argv[2];

if (!action) {
  console.error('An action of either "copy" or "cleanup" must be specified.');
  process.exit(1);
}

const currentDir = process.cwd();
const packageName = path.basename(currentDir);
const sourceDir = path.join(__dirname, '..', 'shared');
const targetDir = path.join(currentDir, 'shared');

const copyDir = async () => {
  try {
    await fs.copy(sourceDir, targetDir);
    console.log(`shared directory copied into ${packageName} successfully.`);
  } catch (err) {
    console.error('Error copying shared directory:', err);
    process.exit(1);
  }
};

const removeDir = async () => {
  try {
    await fs.remove(targetDir);
    console.log(`shared directory removed from ${packageName} successfully.`);
  } catch (err) {
    console.error('Error removing directory:', err);
    process.exit(1);
  }
};

const main = async () => {
  if (action === 'copy') {
    await copyDir();
  } else if (action === 'cleanup') {
    await removeDir();
  } else {
    console.error('Invalid action. Use "copy" or "cleanup".');
    process.exit(1);
  }
};

main().catch(err => {
  console.error('Unexpected error:', err);
  process.exit(1);
});
